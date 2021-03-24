CREATE TABLE tiendas (
    id_tienda   NUMBER(12) NOT NULL,
    ciudad      VARCHAR2(50) NOT NULL,
    nombre      VARCHAR2(50) NOT NULL,
    direccion   VARCHAR2(100) NOT NULL,
    telefono    VARCHAR2(30) NOT NULL
);
ALTER TABLE tiendas ADD CONSTRAINT tiendas_pk PRIMARY KEY ( id_tienda );
/
CREATE TABLE repuestos (
    id_repuesto   NUMBER(12) NOT NULL,
    id_tienda     NUMBER(12) NOT NULL,
    nombre        VARCHAR2(100) NOT NULL,
    marca         VARCHAR2(30) NOT NULL,
    precio        NUMBER(8,2) NOT NULL,
    cantidad      NUMBER(3) NOT NULL,
    descuento     NUMBER(2,2)
);
ALTER TABLE repuestos ADD CONSTRAINT repuestos_pk PRIMARY KEY ( id_repuesto );
ALTER TABLE repuestos ADD CONSTRAINT fk_repuestos_tiendas FOREIGN KEY ( id_tienda ) REFERENCES tiendas ( id_tienda );
/
CREATE TABLE servicios (
    id_servicio        NUMBER(12) NOT NULL,
    tipo_servicio      VARCHAR2(1) NOT NULL,
    servicio           VARCHAR2(100) NOT NULL,
    precio_mano_obra   NUMBER(7,2) NOT NULL,
    descuento          NUMBER(2,2),
    valor_minimo       NUMBER(7,2) NOT NULL,
    valor_maximo       NUMBER(9,2) NOT NULL
);
ALTER TABLE servicios ADD CONSTRAINT servicios_pk PRIMARY KEY ( id_servicio );
/
CREATE TABLE tiendas (
    id_tienda   NUMBER(12) NOT NULL,
    ciudad      VARCHAR2(50) NOT NULL,
    nombre      VARCHAR2(50) NOT NULL,
    direccion   VARCHAR2(100) NOT NULL,
    telefono    VARCHAR2(30) NOT NULL
);
ALTER TABLE tiendas ADD CONSTRAINT tiendas_pk PRIMARY KEY ( id_tienda );
/
CREATE TABLE mantenimiento (
    id_mantenimiento   NUMBER(12) NOT NULL,
    placa              VARCHAR2(6) NOT NULL,
    id_tienda          NUMBER(12) NOT NULL,
    estado             VARCHAR2(1)
);
ALTER TABLE mantenimiento ADD CHECK ( estado IN ('P','T'));
ALTER TABLE mantenimiento ADD CONSTRAINT mantenimiento_pk PRIMARY KEY ( id_mantenimiento );
ALTER TABLE mantenimiento ADD CONSTRAINT fk_manteni_vehi FOREIGN KEY ( placa )REFERENCES vehiculo ( placa );
ALTER TABLE mantenimiento ADD CONSTRAINT fk_mant_tienda FOREIGN KEY ( id_tienda ) REFERENCES tiendas ( id_tienda );

/
CREATE TABLE mantenimi_repuest (
    id_repuesto        NUMBER(12) NOT NULL,
    id_mantenimiento   NUMBER(12) NOT NULL,
    cantidad           NUMBER(3) NOT NULL
);
ALTER TABLE mantenimi_repuest ADD CONSTRAINT fk_mant_repu FOREIGN KEY ( id_mantenimiento ) REFERENCES mantenimiento ( id_mantenimiento );
ALTER TABLE mantenimi_repuest ADD CONSTRAINT fk_repu_mant FOREIGN KEY ( id_repuesto ) REFERENCES repuestos ( id_repuesto );
/
CREATE TABLE mantemini_servicios (
    id_servicio        NUMBER(12) NOT NULL,
    id_mantenimiento   NUMBER(12) NOT NULL
);
ALTER TABLE mantemini_servicios ADD CONSTRAINT fk_mante_servic FOREIGN KEY ( id_mantenimiento ) REFERENCES mantenimiento ( id_mantenimiento );
ALTER TABLE mantemini_servicios ADD CONSTRAINT fk_servic_mante FOREIGN KEY ( id_servicio ) REFERENCES servicios ( id_servicio );
/
CREATE TABLE persona (
    id_persona           NUMBER(12) NOT NULL,
    primer_nombre        VARCHAR2(20) NOT NULL,
    segundo_nombre       VARCHAR2(20),
    primer_apellido      VARCHAR2(20) NOT NULL,
    segundo_apellido     VARCHAR2(20),
    tipo_documento       VARCHAR2(2) NOT NULL,
    numero_documento     NUMBER(15) NOT NULL,
    celular              NUMBER(10),
    direccion            VARCHAR2(100),
    correo_electronico   VARCHAR2(50)
);
ALTER TABLE persona ADD CONSTRAINT persona_pk PRIMARY KEY ( id_persona );
/
CREATE TABLE cliente (
    id_cliente     NUMBER(12) NOT NULL,
    id_persona     NUMBER(12) NOT NULL,
    valor_limite   NUMBER(9,2)
);
ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );
ALTER TABLE cliente ADD CONSTRAINT fk_cli_pers FOREIGN KEY ( id_persona ) REFERENCES persona ( id_persona );
/
CREATE TABLE empleado (
    id_empleado     NUMBER(12) NOT NULL,
    id_persona      NUMBER(12) NOT NULL,
    tipo_empleado   VARCHAR2(10) NOT NULL,
    estado          VARCHAR2(1)
);
ALTER TABLE empleado ADD CONSTRAINT empleados_pk PRIMARY KEY ( id_empleado );
ALTER TABLE empleado ADD CONSTRAINT fk_emp_pers FOREIGN KEY ( id_persona ) REFERENCES persona ( id_persona );
/
CREATE TABLE fotos (
    id_foto     NUMBER(12) NOT NULL,
    ruta_foto   VARCHAR2(200) NOT NULL
);
ALTER TABLE fotos ADD CONSTRAINT fotos_pk PRIMARY KEY ( id_foto );
/
CREATE TABLE vehiculo (
    placa          VARCHAR2(6) NOT NULL,
    id_cliente     NUMBER(12) NOT NULL,
    marca          VARCHAR2(20) NOT NULL,
    modelo         VARCHAR2(20) NOT NULL,
    ano            NUMBER(4) NOT NULL,
    color          VARCHAR2(10) NOT NULL,
    tipo           VARCHAR2(20),
    cant_puertas   NUMBER(1) NOT NULL
);
ALTER TABLE vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( placa );
ALTER TABLE vehiculo ADD CONSTRAINT fk_vehiculo_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente ( id_cliente );
/
CREATE TABLE vehiculo_fotos (
    placa     VARCHAR2(6) NOT NULL,
    id_foto   NUMBER(12) NOT NULL
);
ALTER TABLE vehiculo_fotos ADD CONSTRAINT fk_fot_vehi FOREIGN KEY ( id_foto ) REFERENCES fotos ( id_foto );
ALTER TABLE vehiculo_fotos ADD CONSTRAINT fk_vehi_fotos FOREIGN KEY ( placa ) REFERENCES vehiculo ( placa );
/

CREATE TABLE factura (
    numero_factura     NUMBER(12) NOT NULL,
    fecha              DATE NOT NULL,
    id_cliente         NUMBER(12) NOT NULL,
    id_empleado        NUMBER(12) NOT NULL,
    id_mantenimiento   NUMBER(12) NOT NULL,
    subtotal           NUMBER(9,2),
    impuesto           NUMBER(9,2),
    descuento          NUMBER(8,2),
    total              NUMBER(9,2)
);
ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( numero_factura );
ALTER TABLE factura ADD CONSTRAINT fk_factura_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente ( id_cliente );
ALTER TABLE factura ADD CONSTRAINT fk_factura_empleados FOREIGN KEY ( id_empleado ) REFERENCES empleado ( id_empleado );
ALTER TABLE factura ADD CONSTRAINT fk_factura_mantenimiento FOREIGN KEY ( id_mantenimiento ) REFERENCES mantenimiento ( id_mantenimiento );
/        
