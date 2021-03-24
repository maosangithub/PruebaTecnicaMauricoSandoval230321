-- 5.Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días
SELECT P.tipo_documento,
       P.numero_documento,
       P.primer_nombre||' '||P.segundo_nombre||' '||P.primer_apellido||' '||P.segundo_apellido AS nombre,
       p.celular,
       P.direccion,
       P.correo_electronico
  FROM persona p,
       cliente c
 WHERE p.id_persona = c.id_persona
   AND c.id_cliente IN (SELECT id_cliente
                          FROM (SELECT c.id_cliente,
                                       SUM(f.total) 
                                  FROM cliente c,
                                       factura f
                                 WHERE c.ID_CLIENTE = f.ID_CLIENTE
                                   AND TRUNC(f.fecha) > sysdate-60
                                 GROUP BY c.id_cliente   
                                HAVING SUM(total) > 100000));      
/
-- 6.Consulta de los 100 productos más vendidos en los últimos 30 días

SELECT r.*
  FROM repuestos r
 WHERE r.id_repuesto IN (SELECT id_repuesto
                           FROM (SELECT mr.id_repuesto,
                                        SUM(cantidad)
                                   FROM mantenimiento m,
                                        mantenimi_repuest mr,
                                        factura f
                                  WHERE m.id_mantenimiento = mr.id_mantenimiento
                                    AND m.id_mantenimiento = f.id_mantenimiento
                                    AND TRUNC(f.fecha) > SYSDATE-30
                                  GROUP BY mr.id_repuesto
                                  ORDER BY 2 DESC ))
  AND ROWNUM < 101;
/
--7. Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.
 
SELECT s.*
  FROM tiendas s
 WHERE s.id_tienda IN (SELECT id_tienda
                         FROM (SELECT t.id_tienda,
                                       SUM(cantidad)
                                  FROM mantenimiento m,
                                       mantenimi_repuest mr,
                                       factura f,
                                       tiendas t
                                 WHERE m.id_mantenimiento = mr.id_mantenimiento
                                   AND m.id_mantenimiento = f.id_mantenimiento
                                   AND m.id_tienda = t.id_tienda
                                   AND mr.id_repuesto = 100
                                   AND TRUNC(f.fecha) > SYSDATE-60
                                 GROUP BY t.id_tienda
                                HAVING SUM(cantidad) > 100));
/
--8. Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.

SELECT P.tipo_documento,
       P.numero_documento,
       P.primer_nombre||' '||P.segundo_nombre||' '||P.primer_apellido||' '||P.segundo_apellido AS nombre,
       p.celular,
       P.direccion,
       P.correo_electronico
  FROM persona p,
       cliente c
 WHERE p.id_persona = c.id_persona
   AND c.id_cliente IN (SELECT id_cliente
                          FROM (SELECT cli.id_cliente,
                                       m.id_mantenimiento,
                                       COUNT(*)
                                  FROM factura f,
                                       mantenimiento m,
                                       cliente cli
                                 WHERE f.id_mantenimiento = m.id_mantenimiento      
                                   AND f.id_cliente = cli.id_cliente
                                   AND f.fecha > SYSDATE-30
                                 GROUP BY cli.id_cliente,
                                          m.id_mantenimiento  
                                HAVING COUNT(*) > 1 ))
;