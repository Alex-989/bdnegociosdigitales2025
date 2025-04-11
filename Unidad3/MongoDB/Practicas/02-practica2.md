# Consultas

1. Cargar el archivo empleados.json


2. Utilizar la base de datos curso


3. Buscar todos los empleados que trabajen en google
```json
db.cursos.find({empresa:'Google'})
```

4. Empleados que vivan en peru
```json
db.cursos.find({pais:'Peru'})
```

5. Empleados que ganen mas de 8000 dolares
```json
db.cursos.find({salario:{$gt : 8000}}) 
```

6. Empleados con ventas inferiores a 10000
```json
db.cursos.find({ventas:{$lt : 10000}}) 
```

7. Realizar la consulta anterior pero devolviendo una sola fila
```json
db.cursos.findOne({ventas:{$lt : 10000}}) 
```

8. Empleados que trabajan en google o en yahoo con el operador $in
```json
db.cursos.find(
    {
        empresa: {
            $in:['Google', 'Yahoo']
        }
    }
)
```

9. Empleados de amazon que ganen mas de 8000 dolares
```json
db.cursos.find(
    {$and:[{empresa:'Amazon'},
                {salario:{$gt:8000}}]})
```

10. Empleados que trabajan en Google o en Yahoo con el operador $or
```json
db.cursos.find(
        {
            $or:[
                {
                    empresa:'Google'
                },
                {
                    empresa:'Yahoo'
                }
                ]
         }
 )
```

11. Empleados que trabajen en Yahoo que ganen mas de 6000 o empleados que trabajen en Google que tengan ventas inferiores a 20000
```json
db.cursos.find(
       {
        $and:[
            {$or: [{empresa: 'Yahoo'}, {salario:{$gt:6000}}]},
            { $or: [{empresa:'Google'}, {salario:{$lt:20000}}]}
        ]
       }

)
```

12. Visualizar el nombre, apellidos y el país de cada empleado
```json
db.cursos.find({},{nombre: 1, apellidos: 1, pais: 1})
```