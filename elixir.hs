--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative    ((<$>))
import Data.List            (isPrefixOf)
import Data.Monoid            (mappend)
import Data.Text            (pack,unpack,replace,empty)
import System.FilePath        (takeFileName)
import Text.Pandoc

import Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    -- Build Tags
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")

    -- Compress CSS
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Copy images
    match ("images/*" .||. "images/*/*") $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy files
    match ("files/*") $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy About Page
    match ("about/*" .||. "about/*/*") $ do
        route   idRoute
        compile copyFileCompiler

    -- Contact Page
    match (fromList ["contact.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocMathCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Render posts
    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocMathCompiler
            >>= loadAndApplyTemplate "templates/post.html"    (tagsCtx tags)
            >>= (externalizeUrls $ feedRoot feedConfiguration)
            >>= saveSnapshot "content"
            >>= (unExternalizeUrls $ feedRoot feedConfiguration)
            >>= loadAndApplyTemplate "templates/post-js.html" (tagsCtx tags)
            >>= loadAndApplyTemplate "templates/default.html" (tagsCtx tags)
            >>= relativizeUrls

    -- Archive Page
    create ["archive.html"] $ do
        route idRoute
        compile $ do
            list <- postList tags "posts/*" recentFirst
            makeItem list
            >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
            >>= loadAndApplyTemplate "templates/default.html" archiveCtx
            >>= relativizeUrls


    -- Home Page
    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- postList tags "posts/*" (fmap (take 10) . recentFirst)
            makeItem posts
            >>= loadAndApplyTemplate "templates/index.html" homeCtx
            >>= loadAndApplyTemplate "templates/default.html" homeCtx
            >>= relativizeUrls

    -- Render Tags
    tagsRules tags $ \tag pattern -> do
        let title = "Posts tagged '" ++ tag ++ "'"
        route idRoute
        compile $ do
            list <- postList tags pattern recentFirst
            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html"
                    (constField "title" title `mappend`
                        constField "body" list `mappend`
                        defaultContext)
                >>= loadAndApplyTemplate "templates/default.html"
                    (constField "title" title `mappend`
                        defaultContext)
                >>= relativizeUrls

    -- Render RSS feed
    create ["rss.xml"] $ do
        route idRoute
        compile $ do
            loadAllSnapshots "posts/*" "content"
                >>= recentFirst
                >>= renderRss feedConfiguration feedCtx

    -- Load templates
    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------

-- Contexts

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

archiveCtx :: Context String
archiveCtx =
    constField "title" "Archives" `mappend`
    postCtx

homeCtx :: Context String
homeCtx =
    constField "title" "Home" `mappend`
    postCtx

tagsCtx :: Tags -> Context String
tagsCtx tags =
    tagsField "prettytags" tags `mappend`
    postCtx

feedCtx :: Context String
feedCtx =
    bodyField "description" `mappend`
    postCtx

--------------------------------------------------------------------------------

-- Configuration

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "Yinyanghu's blog - RSS feed"
    , feedDescription = "Miscellaneous Gallery of Life"
    , feedAuthorName  = "Jian Li"
    , feedAuthorEmail = "lijianxp2005@gmail.com"
    , feedRoot        = "http://yinyanghu.github.io"
    }

pandocMathCompiler = pandocCompilerWith readers writers
    where
        readers = def { readerExtensions = pandocExtensions }
        writers = def {
            writerHTMLMathMethod = MathJax "",
            writerHtml5 = True
        }

externalizeUrls :: String -> Item String -> Compiler (Item String)
externalizeUrls root item = return $ fmap (externalizeUrlsWith root) item

externalizeUrlsWith :: String  -- ^ Path to the site root
                    -> String  -- ^ HTML to externalize
                    -> String  -- ^ Resulting HTML
externalizeUrlsWith root = withUrls ext
  where
    ext x = if isExternal x then x else root ++ x

unExternalizeUrls :: String -> Item String -> Compiler (Item String)
unExternalizeUrls root item = return $ fmap (unExternalizeUrlsWith root) item

unExternalizeUrlsWith :: String  -- ^ Path to the site root
                      -> String  -- ^ HTML to unExternalize
                      -> String  -- ^ Resulting HTML
unExternalizeUrlsWith root = withUrls unExt
  where
    unExt x = if root `isPrefixOf` x then unpack $ replace (pack root) empty (pack x) else x



postList :: Tags -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler String
postList tags pattern preprocess' = do
    postItemTpl <- loadBody "templates/post-item.html"
    posts <- preprocess' =<< loadAll pattern
    applyTemplateList postItemTpl (tagsCtx tags) posts

