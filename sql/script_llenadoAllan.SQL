-- Insertando Informacion (Usuarios,Clientes,Proveedores) -- select * from info_obj;


--Insertando Unidad Medida -- select * from unidadmedidad_obj;

INSERT INTO unidadmedidad_obj VALUES('PE', 'Peso');
INSERT INTO unidadmedidad_obj VALUES('UN', 'Unidad');
INSERT INTO unidadmedidad_obj VALUES('OT', 'Otro');

-- Insertando Usuarios -- SELECT * FROM Usuarios_obj --Delete from Usuarios_obj where codigo = 'ARD';

--Usuarios
Insert into Info_Obj Values ( '1','allanjose91@gmail.com','23',SYSDATE);
Insert into Info_Obj Values ( '2','aallanrd@gmail.com','23',SYSDATE);
Insert into Info_Obj Values ( '5','arojas_268@hotmail.com','23',SYSDATE);

INSERT INTO Usuarios_obj VALUES('ARD', 'Allan',   'aallanrd',  '1234',(SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '1'));
INSERT INTO Usuarios_obj VALUES('JGM', 'Jose',    'josegm'  ,  '1234',(SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '2'));
INSERT INTO Usuarios_obj VALUES('DPC', 'Daniel',  'danielpc',  '1234',(SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '5'));

-- Insertando Clientes -- SELECT * FROM Clientes_obj --Delete from Clientes_obj where codigo = 'Lateralis';

--Clientes
Insert into Info_Obj Values ( '3','ufotv.show@gmail.com','23',SYSDATE);
Insert into Info_Obj Values ( '4','lateraliscr@gmail.com','23',SYSDATE);

INSERT INTO Clientes_obj VALUES('UFO',       'UFO',          'ufotv'        ,(SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '3'));
INSERT INTO Clientes_obj VALUES('Lateralis', 'Lateralis',    'lateralis'   ,(SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '4'));

-- Insertando Proveedores -- SELECT * FROM Proveedores_Obj --Delete from Proveedores_Obj where codigo = 'AMD';

--Proveedores
Insert into Info_Obj Values ( '6','intel@intel.com','23',SYSDATE);
Insert into Info_Obj Values ( '7','amd@amd.com','23',SYSDATE);

INSERT INTO Proveedores_Obj VALUES('INTELI',  'Intel', 'ufotv'     , (SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '6'));
INSERT INTO Proveedores_Obj VALUES('AMD',    'AmD',   'lateralis' , (SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = '7'));



insert into familias_obj values ('Default','FAMILIA xDEFECTO',10);






