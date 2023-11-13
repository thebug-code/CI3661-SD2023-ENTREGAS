-- Tipo de arbol
data ArbolMB a = Vacio
               | RamaM a (ArbolMB a)
               | RamaB a (ArbolMB a) (ArbolMB a)

-- a) Constructores de datos (solo tipos)
vacio :: ArbolMB a

ramaM :: a -> ArbolMB a -> ArbolMB a

ramaB :: a -> ArbolMB a -> ArbolMB a -> ArbolMB a

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
    transRamaM v x = Just (v, v, True)
    transRamaB v x y = do
      (lmin, lmax, isSortedLeft) <- x
      (rmin, rmax, isSortedRight) <- y
      let xmin = minimum [v, lmin, rmin]
          xmax = maximum [v, lmax, rmax]
          isSorted = isSortedLeft && isSortedRight && (v >= lmax) && (v <= rmin)
      return (xmin, xmax, isSorted)

-- g) Para un tipo de datos mas general Gen a, con n constructores diferentes.
-- Si se quisiera crear una funcion plegarGen, con un comportamiento similar 
-- al de plegarArbolMB, la funcion deberia tomar como argumentos una funcion
-- por cada uno de los n constructores, demás del valor de tipo Gen a que se
-- desea plegar.

-- Test
main = do
  let arbol = RamaB 5 (RamaB 3 (RamaB 2 Vacio Vacio) (RamaB 4 Vacio Vacio)) (RamaB 7 (RamaB 6 Vacio Vacio) (RamaB 8 Vacio Vacio))
  let arbol1 = RamaB 8 (RamaB 3 (RamaM 1 Vacio) (RamaB 6 (RamaM 4 Vacio) (RamaM 7 Vacio))) (RamaB 10 Vacio (RamaB 14 (RamaM 13 Vacio) Vacio))
  let arbol2 = RamaB 8 (RamaB 3 (RamaM 1 Vacio) (RamaB 6 (RamaM 4 Vacio) (RamaM 7 Vacio))) (RamaB 10 (RamaM 7 Vacio) (RamaM 14 Vacio))
  print $ sumarArbolMB arbol
  print $ aplanarArbolMB arbol
--  print $ analizarArbolMB arbol1
--  print $ analizarArbolMB arbol2
--  print $ aplanarArbolMB arbol2
