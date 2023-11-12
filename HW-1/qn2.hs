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

trnasformarVacio :: b

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
