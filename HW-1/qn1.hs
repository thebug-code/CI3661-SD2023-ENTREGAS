-- Tipo conjunto de elementos
type Conjunto a = a -> Bool

-- Conjunto de numeros enteros pares
pares :: Conjunto Int
pares = (\num -> even num)

-- Funciones

-- a) Retorna la pertenencia en el conjunto dado, de un elemento dado
miembro :: Conjunto a -> a -> Bool
miembro f e = f e

-- b) Retorna el conjunto vacio
vacio :: Conjunto a
vacio = (\e -> False)

-- c) Retorna un conjunto que contiene unicamnete al elemento dado
singleton :: (Eq a) => a -> Conjunto a
singleton e = (\x -> x == e)

-- d) Retorna un conjunto que contiene todos los elementos de la lista dada
desdeLista :: (Eq a) => [a] -> Conjunto a
desdeLista [] = vacio
desdeLista (x:xs) = (\e -> e == x || miembro (desdeLista xs) e)

-- e) Retorna un conjunto que contiene unicamente todos los elementos que no estan
--   en el conjunto dado (del mismo tipo)
complemento :: Conjunto a -> a -> Bool
complemento c = (\e -> not (miembro c e))

-- f) Retorna un conjunto que contiene los elementos de cada conjunto dado
union :: Conjunto a -> Conjunto a -> Conjunto a
union c1 c2 = (\e -> miembro c1 e || miembro c2 e)

-- h) Retorna un conjunto que contiene solo los elementos que estan en los dos
-- conjuntos proporcionados
interseccion :: Conjunto a -> Conjunto a -> Conjunto a
interseccion c1 c2 = (\e -> miembro c1 e && miembro c2 e)
