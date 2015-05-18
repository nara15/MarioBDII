--CREATE OR REPLACE TYPE T_FacturaCompra;

CREATE OR REPLACE TYPE T_FacturaCompra AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    marca      VARCHAR2 (20 CHAR) ,
    modelo     VARCHAR2 (20) ,
    cantMin NUMBER (3) ,
    cantMax NUMBER (5) ,
    precio FLOAT ,
    fechaRegistro   DATE ,
    proveedor ref T_Proveedores,
    usuario ref T_Usuarios,
    unidad ref T_UnidadMedida,
    
   
    CONSTRUCTOR FUNCTION T_FacturaCompra(
    
        pCodigo     IN VARCHAR2 ,
        pNombre     IN VARCHAR2 ,
        pMarca      IN VARCHAR2 ,
        pModelo     IN VARCHAR2 ,
        pCantMin    IN NUMBER ,
        pCantMax    IN NUMBER ,
        pPrecio     IN FLOAT ,
        fechaRegistro IN  DATE 
     
        )
      RETURN SELF
    AS
      RESULT ) FINAL ;

CREATE TABLE FacturaCompra_OBJ OF T_FacturaCompra
  (
    codigo NOT NULL,
    nombre NOT NULL ,
    marca NOT NULL ,
    modelo NOT NULL ,
    cantMin NOT NULL ,
    cantMax NOT NULL ,
    precio NOT NULL ,
    fechaRegistro NOT NULL ,
       
    CONSTRAINT facCompra_PK PRIMARY KEY ( codigo ),
    CONSTRAINT facCompra_userI_FK FOREIGN KEY (usuario) REFERENCES Usuarios_OBJ,
    CONSTRAINT facCompra_prove_FK FOREIGN KEY (proveedor) REFERENCES Proveedores_OBJ,
    CONSTRAINT facCompra_unidad_FK FOREIGN KEY (unidad) REFERENCES UnidadMedidad_OBJ
    
  ) ;