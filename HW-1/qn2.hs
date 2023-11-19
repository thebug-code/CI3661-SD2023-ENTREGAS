-- Tipo de arbol
data ArbolMB a = Vacio
               | RamaM a (ArbolMB a)
               | RamaB a (ArbolMB a) (ArbolMB a)

-- a) Constructores de datos (solo tipos) -> en el informe

--b) Transforma valores de tipo (ArbolMB a) en algun otro tipo b.
-- Se supone que cada argumento de tipo (ArbolMB a) ya ha sido
-- transformado a b
transformarRamaM :: a -> b -> b

transformarRamaB :: a -> b -> b -> b

transformarVacio :: b

-- c) Funcion transformadora
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

-- d) Dado un valor de tipo (Num a) => ArbolMB a calcula y retorna la 
-- suma de todos datos almacenados en el tipo
sumarArbolMB :: (Num a) => ArbolMB a -> a
sumarArbolMB = plegarArbolMB transVacio transRamaM transRamaB
  where
    transVacio = 0
    transRamaM = \x y -> x + y
    transRamaB = \x y z -> x + y + z

-- e) Dado un valor de tipo ArbolMB a calcula y retorna una sola lista
-- con todos los elementos contenidos en la estructura (en el orden
-- in-order)
aplanarArbolMB :: ArbolMB a -> [a]
aplanarArbolMB = plegarArbolMB transVacio transRamaM transRamaB
  where
    transVacio = []
    transRamaM = \x y -> [x] ++ y
    transRamaB = \x y z -> y ++ [x] ++ z

-- f) Dado un valor de tipo (Ord a) => ArbolMB a calcula y retorna
-- posiblemente una tupla con 3 elementos. El primero es el minimo
-- elemento presente en la estructura, el segundo es el maximo y el
-- tercero es un booleano que es cierto si y solo si la lista que
-- resultaria de llamar a la funcion aplanarArbolMB estaria ordenada
-- de menor a mayor (esto es, que sea un arbol de busqueda)
analizarArbolMB :: (Ord a) => ArbolMB a -> Maybe (a, a, Bool)
analizarArbolMB = plegarArbolMB transVacio transRamaM transRamaB
  where
    transVacio = Nothing
    transRamaM = \x y -> case y of
      Nothing -> Just (x, x, True)
      Just (ymin, ymax, isSorted) -> Just (min x ymin, max x ymax, isSorted && x >= ymin)
    transRamaB = \x y z -> case (y, z) of
      (Nothing, Nothing) -> Just (x, x, True)
      (Nothing, Just (zmin, zmax, isSorted)) -> Just (min x zmin, max x zmax, isSorted && x <= zmin)
      (Just (ymin, ymax, isSorted), Nothing) -> Just (min x ymin, max x ymax, isSorted && x >= ymin)
      (Just (ymin, ymax, isSorted1), Just (zmin, zmax, isSorted2)) -> Just (min x (min ymin zmin), max x (max ymax zmax), isSorted1 && isSorted2 && x >= ymin && x <= zmin)
      
-- g) en el informe

-- h) en el informe

-- Test
--main = do
--  let arbol = RamaB 5 (RamaB 3 (RamaB 2 Vacio Vacio) (RamaB 4 Vacio Vacio)) (RamaB 7 (RamaB 6 Vacio Vacio) (RamaB 8 Vacio Vacio))
--  let arbol1 = RamaB 8 (RamaB 3 (RamaM 1 Vacio) (RamaB 6 (RamaM 4 Vacio) (RamaM 7 Vacio))) (RamaB 10 Vacio (RamaB 14 (RamaM 13 Vacio) Vacio))
--  let arbol2 = RamaB 8 (RamaB 3 (RamaM 1 Vacio) (RamaB 6 (RamaM 4 Vacio) (RamaM 7 Vacio))) (RamaB 10 (RamaM 7 Vacio) (RamaM 14 Vacio))
--  print $ sumarArbolMB arbol
--  print $ aplanarArbolMB arbol
--  print $ aplanarArbolMB arbol1
--  print $ aplanarArbolMB arbol2
--  print $ analizarArbolMB arbol
--  print $ analizarArbolMB arbol1
--  print $ analizarArbolMB arbol2
