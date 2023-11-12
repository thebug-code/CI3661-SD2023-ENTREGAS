-- Tipo de arbol
data ArbolMB a = Vacio
               | RamaM a (ArbolMB a)
               | RamaB a (ArbolMB a) (ArbolMB a)

-- Constructores de datos (solo tipos)
vacio :: ArbolMB a

ramaM :: a -> ArbolMB a -> ArbolMB a

ramaB :: a -> ArbolMB a -> ArbolMB a -> ArbolMB a

-- Transforma valores de tipo (ArbolMB a) en algun otro tipo b.
-- Se supone que cada argumento de tipo (ArbolMB a) ya ha sido
-- transformado a b
transformarRamaM :: a -> b -> b

transformarRamaB :: a -> b -> b -> b

transformarVacio :: b

-- Funcion transformadora
plegarArbolMB :: (b) 
              -> (a -> b -> b)
              -> (a -> b -> b -> b)
              -> ArbolMB a
              -> b
plegarArbolMB transVacio transRamaM transRamaB = plegar
  where
    plegar Vacio = transVacio
    plegar (RamaM x y) = transRamaM x (plegar y)
    plegar (RamaB x y z) = transRamaB x (plegar y) (plegar z)

-- Dado un valor de tipo (Num a) => ArbolMB a calcula y retorna la 
-- suma de todos datos almacenados en el tipo
sumarArbolMB :: (Num a) => ArbolMB a -> a
sumarArbolMB = plegarArbolMB transVacio transRamaM transRamaB
  where
    transVacio = 0
    transRamaM x y = x + y
    transRamaB x y z = x + y + z

-- Dado un valor de tipo ArbolMB a calcula y retorna una sola lista
-- con todos los elementos contenidos en la estructura (en el orden
-- in-order)
aplanarArbolMB :: ArbolMB a -> [a]
aplanarArbolMB = plegarArbolMB transVacio transRamaM transRamaB
  where
    transVacio = []
    transRamaM x y = y ++ [x]
    transRamaB x y z = y ++ [x] ++ z
