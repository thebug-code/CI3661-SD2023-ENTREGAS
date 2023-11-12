-- Tipo de arbol
data ArbolMB a = Vacio
               | RamaM a (ArbolMB a)
               | RamaB a (ArbolMB a) (ArbolMB a)

-- Constructores de datos
vacio :: ArbolMB a
vacio = Vacio

ramaM :: a -> ArbolMB a -> ArbolMB a
ramaM x a = RamaM x a

ramaB :: a -> ArbolMB a -> ArbolMB a -> ArbolMB a
ramaB x a b = RamaB x a b
