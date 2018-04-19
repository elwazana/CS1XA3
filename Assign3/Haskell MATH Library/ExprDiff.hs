{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE UndecidableInstances #-}
module ExprDiff where

import ExprType

import qualified Data.Map.Strict as Map

class DiffExpr a where
    eval :: Map.Map String a -> Expr a -> a
    simplify :: Map.Map String a -> Expr a -> Expr a
    partDiff :: String -> Expr a -> Expr a
    partAntiDerivative :: String -> Expr a -> Expr a
    newtonsMethod :: Map.Map String a -> String -> Expr a -> a

    (!+) :: Expr a -> Expr a -> Expr a
    e1 !+ e2 = simplify (Map.fromList []) $ Add e1 e2
    (!*) :: Expr a -> Expr a -> Expr a
    e1 !* e2 = simplify (Map.fromList []) $ Mult e1 e2
    (!^) :: Expr a -> Expr a -> Expr a
    e1 !^ e2 = simplify (Map.fromList []) $ Expo e1 e2
    (!/) :: Expr a -> Expr a -> Expr a
    e1 !/ e2 = simplify (Map.fromList []) $ Division e1 e2
    val :: a -> Expr a
    val x = Const x
    var :: String -> Expr a
    var x = Var x
    myCos :: Expr a -> Expr a
    myCos x = Cos x
    mySin :: Expr a -> Expr a
    mySin x = Sin x
    myExp :: Expr a -> Expr a
    myExp x = Exp x
    myLn :: Expr a -> Expr a
    myLn x = Ln x

instance (Floating a,Eq a) => DiffExpr a where
    eval vrs (Add e1 e2)      = eval vrs e1 + eval vrs e2
    eval vrs (Mult e1 e2)     = eval vrs e1 * eval vrs e2
    eval vrs (Division e1 e2) = (eval vrs e1) / (eval vrs e2)
    eval vrs (Cos e)          = cos (eval vrs e)
    eval vrs (Sin e)          = sin (eval vrs e)
    eval vrs (Expo e1 e2)     = (eval vrs e1) ** (eval vrs e2)
    eval vrs (Exp e)          = exp (eval vrs e)
    eval vrs (Ln e)           = log (eval vrs e)  
    eval vrs (Neg e)          = (-1) * (eval vrs e) 
    eval vrs (Const x)        = x
    eval vrs (Var x)          = case Map.lookup x vrs of
                                        Just v  -> v
                                        Nothing -> error "failed lookup in eval"

    partDiff str (Add e1 e2)      = Add (partDiff str e1) (partDiff str e2)
    partDiff str (Mult e1 e2)     = Add (Mult (partDiff str e1) e2) (Mult e1 (partDiff str e2))
    partDiff str (Division e1 e2) = Division (Add (Mult (partDiff str e1) e2) (Mult (Neg e1) (partDiff str e2))) (Expo (e2) (Const 2))
    partDiff str (Cos e)          = Mult (Neg (Sin e)) (partDiff str e)
    partDiff str (Sin e)          = Mult (Cos e) (partDiff str e)
    partDiff str (Expo e1 e2)     = Mult (Ln e1) (Mult (Expo e1 e2) (partDiff str e2)) -- Only for bases as numbers not variables
    partDiff str (Exp e)          = Mult (Exp e) (partDiff str e)
    partDiff str (Ln e)           = Division (partDiff str e) (e)
    partDiff str (Neg e)          = Neg (partDiff str e)
    partDiff str (Const x)        = Const 0
    partDiff str (Var x)          | x == str  = (Const 1)
                                  | otherwise = (Const 0)

    simplify vrs (Const e) = Const e
    simplify vrs (Neg e)   = Const (eval vrs (Neg e))
    simplify vrs (Var x)   = case Map.lookup x vrs of 
                                Just x' -> Const (eval vrs (Var x))
                                Nothing -> Var x
    ---------------------------------------------------------------------------------------------------------------------------

    simplify vrs (Add e1 e2)               = let 
                                                    e1' = simplify vrs e1
                                                    e2' = simplify vrs e2
                                                in case (e1',e2') of 
                                                    (Const a,Const b) -> Const (eval vrs (Add e1' e2'))
                                                    (Const 0,e2')     -> e2' 
                                                    (e1',Const 0)     -> e1'
                                                    (e1',e2')         -> Add e1' e2'
 
    {-simplify vrs (Add (Var x) (Var y))     = case Map.lookup x vrs of 
                                                        Just x' -> case Map.lookup y vrs of
                                                                    Just y' -> Const (eval vrs (Add (Var x) (Var y)))
                                                                    Nothing -> Add (simplify vrs (Var x)) (simplify vrs (Var y))
                                                        Nothing -> Add (simplify vrs (Var x)) (simplify vrs (Var y))
        simplify vrs (Add (Const a) (Var x))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Add (Const a) (Var x)))
                                                    Nothing -> Add (Const a) (Var x)
        simplify vrs (Add e1 (Var x))          = case Map.lookup x vrs of 
                                                    Just x' -> Add (simplify vrs e1) (Const (eval vrs (Var x)))
                                                    Nothing -> Add (simplify vrs e1) (Var x)
        simplify vrs (Add (Var x) (Const b))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Add (Var x) (Const b)))
                                                    Nothing -> Add (Var x) (Const b) 
        simplify vrs (Add (Var x) e2)          = case Map.lookup x vrs of 
                                                    Just x' -> Add (Const (eval vrs (Var x))) (simplify vrs e2)
                                                    Nothing -> Add (Var x) (simplify vrs e2)
        simplify vrs (Add (Const a) (Const b)) = Const (eval vrs (Add (Const a) (Const b)))
        simplify vrs (Add e1 e2)               = Add (simplify vrs e1) (simplify vrs e2)-}
    ------------------------------------------------------------------------------------------------------------------------------
    simplify vrs (Mult e1 e2)               = let 
                                                    e1' = simplify vrs e1
                                                    e2' = simplify vrs e2
                                                in case (e1',e2') of 
                                                    (Const a,Const b) -> Const (eval vrs (Mult e1' e2'))
                                                    (Const 0,e2')     -> Const (0.0) 
                                                    (e1',Const 0)     -> Const (0.0)
                                                    (e1',e2')         -> Mult e1' e2'

    {-simplify vrs (Mult (Var x) (Var y))     = case Map.lookup x vrs of 
                                                    Just x' -> case Map.lookup y vrs of
                                                                Just y' -> Const (eval vrs (Mult (Var x) (Var y)))
                                                                Nothing -> Mult (simplify vrs (Var x)) (simplify vrs (Var y))
                                                    Nothing -> Mult (simplify vrs (Var x)) (simplify vrs (Var y))
        simplify vrs (Mult (Const a) (Var x))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Mult (Const a) (Var x)))
                                                    Nothing -> Mult (Const a) (Var x)
        simplify vrs (Mult e1 (Var x))          = case Map.lookup x vrs of 
                                                    Just x' -> Mult (simplify vrs e1) (Const (eval vrs (Var x)))
                                                    Nothing -> Mult (simplify vrs e1) (Var x)
        simplify vrs (Mult (Var x) (Const b))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Mult (Var x) (Const b)))
                                                    Nothing -> Mult (Var x) (Const b) 
        simplify vrs (Mult (Var x) e2)          = case Map.lookup x vrs of 
                                                    Just x' -> Mult (Const (eval vrs (Var x))) (simplify vrs e2)
                                                    Nothing -> Mult (Var x) (simplify vrs e2)
        simplify vrs (Mult (Const a) (Const b)) = Const (eval vrs (Mult (Const a) (Const b)))
        simplify vrs (Mult e1 e2)               = Mult (simplify vrs e1) (simplify vrs e2)-}
    ------------------------------------------------------------------------------------------------------------------------------

    simplify vrs (Division (Var x) (Var y))     = case Map.lookup x vrs of 
                                                    Just x' -> case Map.lookup y vrs of
                                                                Just y' -> Const (eval vrs (Division (Var x) (Var y)))
                                                                Nothing -> Division (simplify vrs (Var x)) (simplify vrs (Var y))
                                                    Nothing -> Division (simplify vrs (Var x)) (simplify vrs (Var y))
    simplify vrs (Division (Const a) (Var x))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Division (Const a) (Var x)))
                                                    Nothing -> Division (Const a) (Var x)
    simplify vrs (Division e1 (Var x))          = case Map.lookup x vrs of 
                                                    Just x' -> Division (simplify vrs e1) (Const (eval vrs (Var x)))
                                                    Nothing -> Division (simplify vrs e1) (Var x)
    simplify vrs (Division (Var x) (Const b))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Division (Var x) (Const b)))
                                                    Nothing -> Division (Var x) (Const b) 
    simplify vrs (Division (Var x) e2)           = case Map.lookup x vrs of 
                                                    Just x' -> Division (Const (eval vrs (Var x))) (simplify vrs e2)
                                                    Nothing -> Division (Var x) (simplify vrs e2)
    simplify vrs (Division (Const a) (Const b)) = Const (eval vrs (Division (Const a) (Const b)))
    simplify vrs (Division e1 e2)               = Division (simplify vrs e1) (simplify vrs e2)
    ------------------------------------------------------------------------------------------------------------------------------


    simplify vrs (Expo (Var x) (Var y))     = case Map.lookup x vrs of 
                                                    Just x' -> case Map.lookup y vrs of
                                                                Just y' -> Const (eval vrs (Expo (Var x) (Var y)))
                                                                Nothing -> Expo (simplify vrs (Var x)) (simplify vrs (Var y))
                                                    Nothing -> Expo (simplify vrs (Var x)) (simplify vrs (Var y))
    simplify vrs (Expo (Const a) (Var x))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Expo (Const a) (Var x)))
                                                    Nothing -> Expo (Const a) (Var x)
    simplify vrs (Expo e1 (Var x))          = case Map.lookup x vrs of 
                                                    Just x' -> Expo (simplify vrs e1) (Const (eval vrs (Var x)))
                                                    Nothing -> Expo (simplify vrs e1) (Var x)
    simplify vrs (Expo (Var x) (Const b))   = case Map.lookup x vrs of 
                                                    Just x' -> Const (eval vrs (Expo (Var x) (Const b)))
                                                    Nothing -> Expo (Var x) (Const b) 
    simplify vrs (Expo (Var x) e2)           = case Map.lookup x vrs of 
                                                    Just x' -> Expo (Const (eval vrs (Var x))) (simplify vrs e2)
                                                    Nothing -> Expo (Var x) (simplify vrs e2)
    simplify vrs (Expo (Const a) (Const b)) = Const (eval vrs (Expo (Const a) (Const b)))
    simplify vrs (Expo e1 e2)               = Expo (simplify vrs e1) (simplify vrs e2)
    ------------------------------------------------------------------------------------------------------------------------------
    
    simplify vrs (Exp (Var x))         = case Map.lookup x vrs of 
                                            Just x' -> Const (eval vrs (Exp (Var x)))
                                            Nothing -> Exp (Var x)
    simplify vrs (Exp (Const a))       = Const (eval vrs (Exp (Const a)))
    simplify vrs (Exp e)               = Exp (simplify vrs e)
    -----------------------------------------------------------------------------------

    simplify vrs (Sin (Var x))         = case Map.lookup x vrs of 
                                            Just x' -> Const (eval vrs (Sin (Var x)))
                                            Nothing -> Sin (Var x)
    simplify vrs (Sin (Const a))       = Const (eval vrs (Sin (Const a)))
    simplify vrs (Sin e)               = Sin (simplify vrs e)
    -----------------------------------------------------------------------------------

    simplify vrs (Cos (Var x))         = case Map.lookup x vrs of 
                                            Just x' -> Const (eval vrs (Cos (Var x)))
                                            Nothing -> Cos (Var x)
    simplify vrs (Cos (Const a))       = Const (eval vrs (Cos (Const a)))
    simplify vrs (Cos e)               = Cos (simplify vrs e)

    partAntiDerivative str (Const e)                     = Mult (Const e) (Var str)
    partAntiDerivative str (Expo (Const e1) (Const e2))  = Mult (Expo (Const e1) (Const e2)) (Var str)
    partAntiDerivative str (Division (Const a) (Var x))  | x == str  = Mult (Const a) (Ln (Var str))
                                                         | otherwise = Division (Const a) (Var x) 
    partAntiDerivative str (Expo (Var x) (Const n))      = Division (Expo (Var x) (Const (n+1))) (Const (n+1))
    partAntiDerivative str (Add e1 e2)                   = Add (partAntiDerivative str e1) (partAntiDerivative str e2) 
    partAntiDerivative str (Exp (Var x))                 | x == str  = Exp (Var str)
                                                         | otherwise = Exp (Var x)
    partAntiDerivative str (Exp (Const e))               = Mult (Exp (Const e)) (Var str)
    partAntiDerivative str (Sin (Var x))                 | x == str  = Neg (Cos (Var str))
                                                         | otherwise = Sin (Var x)
    partAntiDerivative str (Sin (Const e))               = Mult (Sin (Const e)) (Var str)
    partAntiDerivative str (Cos (Var x))                 | x == str  = Sin (Var str)
                                                         | otherwise = Cos (Var x)
    partAntiDerivative str (Cos (Const e))               = Mult (Cos (Const e)) (Var str)

    newtonsMethod vrs str expr = (eval vrs expr) - ((eval vrs expr) / (eval vrs (partDiff str expr)))