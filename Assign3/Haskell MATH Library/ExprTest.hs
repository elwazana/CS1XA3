module ExprTest where

import           ExprDiff
import           ExprParser
import           ExprPretty
import           ExprType

import qualified Data.Map.Strict as Map
import           Test.QuickCheck

evalProp1 :: Double -> Double -> Bool
evalProp1 a b = eval (Map.fromList [("x",a),("y",b)]) (Add (Var "x") (Var "y")) == a + b
testEvalProp1 = quickCheck evalProp1

evalProp2 :: Double -> Double -> Bool
evalProp2 a b = eval (Map.fromList [("x",a),("y",b)]) (Mult (Var "x") (Var "y")) == a * b
testEvalProp2 = quickCheck evalProp2

evalProp3 :: Double -> Double -> Bool
evalProp3 a b = eval (Map.fromList [("x",a),("y",b)]) (Division (Var "x") (Var "y")) == a / b
testEvalProp3 = quickCheck evalProp3

evalProp4 :: Double -> Double -> Bool
evalProp4 a b = eval (Map.fromList [("x",a),("y",b)]) (Expo (Var "x") (Var "y")) == (a) ** (b)
testEvalProp4 = quickCheck evalProp4

evalProp5 :: Double -> Bool
evalProp5 a = eval (Map.fromList [("x",a)]) (Exp (Var "x")) == exp(a)
testEvalProp5 = quickCheck evalProp5

evalProp6 :: Double -> Bool
evalProp6 a = eval (Map.fromList [("x",a)]) (Cos (Var "x")) == cos(a)
testEvalProp6 = quickCheck evalProp6

evalProp7 :: Double -> Bool
evalProp7 a = eval (Map.fromList [("x",a)]) (Sin (Var "x")) == sin(a)
testEvalProp7 = quickCheck evalProp7

evalProp8 :: Double -> Bool
evalProp8 a = eval (Map.fromList [("x",a)]) (Neg (Var "x")) == -a
testEvalProp8 = quickCheck evalProp8