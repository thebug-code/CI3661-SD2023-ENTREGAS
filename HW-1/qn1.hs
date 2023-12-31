-- Tipo conjunto definido como un predicado sobre un tipo dado
type Conjunto a = a -> Bool

-- Funciones

-- a) Retorna la pertenencia en el conjunto dado, de un elemento dado
miembro :: Conjunto a -> a -> Bool
miembro = id

-- b) Retorna el conjunto vacio
vacio :: Conjunto a
vacio = (\e -> False)

-- c) Retorna un conjunto que contiene unicamente al elemento dado
singleton :: (Eq a) => a -> Conjunto a
singleton e = (\x -> x == e)

-- d) Retorna un conjunto que contiene todos los elementos de la lista dada
desdeLista :: (Eq a) => [a] -> Conjunto a
desdeLista = flip elem

-- e) Retorna un conjunto que contiene unicamente todos los elementos que no estan
--   en el conjunto dado (del mismo tipo)
complemento :: Conjunto a -> Conjunto a
complemento c = (\e -> not (c e))

-- f) Retorna un conjunto que contiene los elementos de cada conjunto dado
union :: Conjunto a -> Conjunto a -> Conjunto a
union c1 c2 = (\e -> c1 e || c2 e)

-- g) Retorna un conjunto que contiene solo los elementos que estan en los dos
--   conjuntos proporcionados
interseccion :: Conjunto a -> Conjunto a -> Conjunto a
interseccion c1 c2 = (\e -> c1 e && c2 e)

-- h) Retorna un conjunto que contiene los elementos del primer conjunto dado,
--   que no estan en el segundo
diferencia :: Conjunto a -> Conjunto a -> Conjunto a
diferencia c1 c2 = (\e -> c1 e && not (c2 e))

-- i) Dada una funcion f y un conjunto A, devuelva un conjunto B tal que A es
--   el resultado de aplicar f a todos los elementos de B
transformar :: (b -> a) -> Conjunto a -> Conjunto b
transformar f c = (\e -> c (f e))
