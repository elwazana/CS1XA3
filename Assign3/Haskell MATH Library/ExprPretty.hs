module ExprPretty where

import           ExprType

parens :: String -> String
parens ss = "(" ++ ss ++ ")"

instance Show a => Show (Expr a) where
  show (Mult e1 e2)     = parens (show e1) ++ " !* " ++ parens (show e2)
  show (Add e1 e2)      = parens (show e1) ++ " !+ " ++ parens (show e2)
  show (Expo e1 e2)     = parens (show e1) ++ " !^ " ++ parens (show e2)
  show (Division e1 e2) = parens (show e1) ++ " !/ " ++ parens (show e2)
  show (Sin e)          = parens $ "mySin \"" ++ (show e) ++ "\""
  show (Cos e)          = parens $ "myCos \"" ++ (show e) ++ "\""
  show (Exp e)          = parens $ "myExp \"" ++ (show e) ++ "\""
  show (Ln e)           = parens $ "myLn \"" ++ (show e) ++ "\""
  show (Var ss)         = parens $ "var \"" ++ ss ++ "\""
  show (Const x)        = parens $ "val " ++ show x