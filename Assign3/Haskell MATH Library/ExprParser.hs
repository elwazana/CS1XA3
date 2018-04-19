{-|
    Module : ExprParser
    Description : Contains a typeclass definition which in-it of itself 
                  defines bult-in functions within the Expr type
    Copyright : (c) Akram Elwazani @2018
    License : WTFPL
    Maintainer : elwazana@mcmaster.ca
    Stability : experimental
    Portability : POSIX
-}

module ExprParser (parseExprD,parseExprF) where

import ExprType

import Text.Parsec
import Text.Parsec.String

{-Module defining parsers to parse some strings into the Expr types. 
  Only the Double and Float type are parsed by the parsers, no 
  instance for integers.-}

parseExprD :: String -> Expr Double
parseExprD ss = case parse setExprD "" ss of
                  Left err   -> error $ show err
                  Right expr -> expr

setExprD :: Parser (Expr Double)
setExprD = termD `chainl1` setOp

termD :: Parser (Expr Double)
termD = (negOp factorD) <|> factorD

factorD :: Parser (Expr Double)
factorD = try doubleParse <|> varParse

parseExprDSec :: String -> Expr Double
parseExprDSec ss = case parse setExprDSec "" ss of 
                    Left err   -> error $ show err
                    Right expr -> expr

setExprDSec :: Parser (Expr Double)
setExprDSec = let secOp = do { op <- setOpSec; 
                               spaces;
                               term <- termDSec;
                               spaces;
                               return $ op term }
                in try secOp <|> termDSec

termDSec :: Parser (Expr Double)
termDSec = (negOp factorD) <|> factorD

doubleParse :: Parser (Expr Double)
doubleParse = do { c <- double;
                   return $ Const c}
-------------------------------------------------------------

parseExprF :: String -> Expr Float
parseExprF ss = case parse setExprF "" ss of
                  Left err   -> error $ show err
                  Right expr -> expr

setExprF :: Parser (Expr Float)
setExprF = termF `chainl1` setOp

termF :: Parser (Expr Float)
termF = (negOp factorF) <|> factorF

factorF :: Parser (Expr Float)
factorF = try floatParse <|> varParse

parseExprFSec :: String -> Expr Float
parseExprFSec ss = case parse setExprFSec "" ss of 
                    Left err   -> error $ show err
                    Right expr -> expr

setExprFSec :: Parser (Expr Float)
setExprFSec = let secOp = do { op <- setOpSec; 
                               spaces;
                               term <- termFSec;
                               spaces;
                               return $ op term}
                in try secOp <|> termFSec

termFSec :: Parser (Expr Float)
termFSec = (negOp factorF) <|> factorF

floatParse :: Parser (Expr Float)
floatParse = do { c <- float;
                  return $ Const c }
-------------------------------------------------------------

-- For subtraction Input must be of the following format: parse_____ "num1 + -num2"
setOp :: Parser (Expr a -> Expr a -> Expr a)
setOp = do { symbol "+"; return Add }
    <|> do { symbol "/"; return Division }
    <|> do { symbol "*"; return Mult }
    <|> do { symbol "^"; return Expo }

setOpSec :: Parser (Expr a -> Expr a)
setOpSec = do { string "cos"; return Cos }
       <|> do { string "sin"; return Sin }
       <|> do { string "ln"; return Ln }
       <|> do { string "exp"; return Exp }

negOp :: Parser (Expr a) -> Parser (Expr a)
negOp p = do { symbol "-";
               expr <- p;
               return $ Neg expr }

varParse :: Parser (Expr a)
varParse = do { var <- many1 letter;
                return $ Var var }
--------------------------------------------------------------

symbol :: String -> Parser String
symbol ss = let
  symbol' :: Parser String
  symbol' = do { spaces;
                 ss' <- string ss;
                 spaces;
                 return ss' }
  in try symbol'

digits :: Parser String
digits = many1 digit

negDigits :: Parser String
negDigits = do { neg <- symbol "-" ;
                 dig <- digits ;
                 return (neg ++ dig) }

doubleDigits :: Parser String 
doubleDigits = do { front <- try negDigits <|> digits;
                    back  <- try decimals <|> return "";
                    return $ front ++ back }

decimals :: Parser String 
decimals = do { d  <- char '.';
                dd <- digits; 
                return $ d:dd }

double :: Parser Double
double = fmap read $ doubleDigits 

float :: Parser Float
float = fmap read $ doubleDigits