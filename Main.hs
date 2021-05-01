module Main where

import           System.Environment     (getArgs)

import qualified Data.ByteString.Lazy   as LBS
import           Control.Lens.Operators as LOps
import qualified System.Random          as Rand
import qualified Network.Wreq           as Wreq 

type Handler = LBS.ByteString -> IO ()


main :: IO ()
main = do
  args <- getArgs
  randgen <- Rand.getStdGen
  let (idx, _) = Rand.randomR (1, 500) randgen :: (Int, Rand.StdGen)
  let req = "https://www.emotingmokou.moe/images/emotes/" ++ show idx ++ ".jpg"
  resp <- Wreq.get req
  let status = resp ^. Wreq.responseStatus ^. Wreq.statusCode
  if status /= 200 then
    putStrLn "Couldn't get mokoe :(((((((((" else do
      let body = resp ^. Wreq.responseBody
      parseArgs (if length args > 0 then Just (head args) else Nothing) $ body 


parseArgs :: Maybe String -> Handler
parseArgs args = case args of
  Nothing -> toFile "./mokoe.jpg"
  Just x -> fromArg x
  where
    -- TODO: Add other output methods (imgcat, open in default picture app)
    fromArg :: String -> Handler
    fromArg s | otherwise = toFile s

toFile :: String -> Handler
toFile s = \bs -> do
  LBS.writeFile s bs
  putStrLn $ "Wrote to '" ++ s ++ "'"
