-- Tipo de datos para representar computos secuenciales
newtype Secuencial s a = Secuencial (s -> (a,s))

--newtype State s a = State { runState :: s -> (a, s) }

--fromStoAandS :: Int -> (String,Int)
--fromStoAandS c | c `mod` 5 == 0 = ("foo",c+1)
--               | otherwise = ("bar",c+1)
--
--stateIntString :: State Int String
--stateIntString = State fromStoAandS
--
---- Con secuencial
--stateIntString' :: Secuencial Int String
--stateIntString' = Secuencial fromStoAandS
--
--runSecuencial :: Secuencial s a -> s -> (a,s)
--runSecuencial (Secuencial f) s = f s
--
--main = do
--  print $ runState stateIntString 0
--  print $ runSecuencial stateIntString' 0


-- Queremos que nuestro tipo sea un monad, por lo que haremos una instancia para el
-- instance Monad (Secuencial s) where ...

-- a) ¿Por que se tomo (Secuencial s) como la instancia para el monad y no simplemente Secuencial?
-- El tipo de Secuencial en terminos de kind es * -> * -> * (toma dos parámetros de tipo 's' y 'a'
-- y genera un tipo concreto) y el tipo de Monad es * -> * (toma un parámetro de tipo y genera un
-- tipo concreto). Al agregar el parámetro de tipo 's' a Secuencial, hacemos que el tipo de Secuencial
-- sea * -> * y por lo tanto, sea compatible con el tipo de Monad.
