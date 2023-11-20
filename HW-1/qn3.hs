-- Tipo de datos para representar computos secuenciales
newtype Secuencial s a = Secuencial (s -> (a,s))

-- a) en el informe

-- b) en el informe

-- c) Implemente la funcion return de tal forma que inyecte el argumento pasado como argumento, dejando el
-- estado inicial intacto. Esto es, dado un estado inicial, el resultado debe ser el argumento pasado junto al
-- estado inicial sin cambios
instance Monad (Secuencial s) where
  return a = Secuencial $ \estadoInicial -> (a, estadoInicial)

-- d) Complete la implementacion de la funcion >>= que se da a continuacion:
  (Secuencial programa) >>= transformador =
    Secuencial $ \estadoInicial ->
      let (resultado, nuevoEstado) = programa estadoInicial
        (Secuencial nuevoPrograma) = transformador resultado
      in nuevoPrograma nuevoEstado

-- e) Demuestre las tres leyes monadicas aplicadas al tipo Secuencial s.
-- Recuerde que las tres leyes monadicas son:
-- Identidad izquierda: return a >>= h == h a
-- Identidad derecha: m >>= return == m
-- Asociatividad: (m >>= g) >>= h == m >>= (\x -> g x >>= h)
