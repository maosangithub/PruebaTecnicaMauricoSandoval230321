CREATE OR REPLACE PROCEDURE p_resta_cant_invent( p_id_tienda tiendas.id_tienda%TYPE, 
                                                 p_id_repuesto repuestos.id_repuesto%TYPE,
                                                 p_cantidad NUMBER) IS
BEGIN
    UPDATE repuestos
       SET cantidad = cantidad - p_cantidad
     WHERE ID_REPUESTO = p_id_repuesto  
       AND ID_TIENDA = p_id_tienda;
    COMMIT;       
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20055,'Fallo en p_resta_cant_invent. ');
END p_resta_cant_invent;
/