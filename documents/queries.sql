SET GLOBAL time_zone = '+1:00';

DROP DATABASE IF EXISTS eam;

DROP USER IF EXISTS 'adminEAM'@'localhost';
CREATE USER 'adminEAM'@'localhost' identified by 'conecta';
GRANT ALL PRIVILEGES ON eam.* TO adminEAM@localhost;
FLUSH PRIVILEGES;

CREATE database eam;
USE eam;

CREATE TABLE Usuarios ( 
	id_usuario VARCHAR(20) PRIMARY KEY,
	password VARCHAR(32) NOT NULL,
	email VARCHAR(80) NOT NULL UNIQUE,
	rango_edad INT NOT NULL,
	barrio VARCHAR(20) NOT NULL,
	es_admin BOOLEAN NOT NULL,
	activo BOOLEAN NOT NULL
);
CREATE TABLE Admins (
	id_admin VARCHAR(9) PRIMARY KEY,
	tlf VARCHAR(9) NOT NULL,
	id_usuario VARCHAR(20) UNIQUE,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);
CREATE TABLE Eventos (
	id_evento INT AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(40) NOT NULL,
	descripcion VARCHAR(1000) NOT NULL,
	fecha DATETIME NOT NULL,
	barrio VARCHAR(20) NOT NULL,
	direccion VARCHAR(60) NOT NULL,
	ruta_img VARCHAR(200) NOT NULL,
	num_img INT NOT NULL,
	cancelado BOOLEAN NOT NULL,
	aprobado BOOLEAN NOT NULL,
	id_creador VARCHAR(20),
	FOREIGN KEY (id_creador) REFERENCES Admins(id_admin)
);
CREATE TABLE Inscritos (
	id_usuario VARCHAR(20),
	id_evento INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
	FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento)
);
CREATE TABLE Hobbies (
	id_hobbie INT AUTO_INCREMENT PRIMARY KEY,
	descripcion VARCHAR(60) NOT NULL
);
CREATE TABLE HobbiesUsuarios (
	id_usuario VARCHAR(20),
	id_hobbie INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
	FOREIGN KEY (id_hobbie) REFERENCES Hobbies(id_hobbie)
);
CREATE TABLE HobbiesEventos (
	id_evento INT,
	id_hobbie INT,
	FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento),
	FOREIGN KEY (id_hobbie) REFERENCES Hobbies(id_hobbie)
);

INSERT INTO Hobbies (descripcion)
VALUES
	('futbol'),
	('baloncesto'),
	('senderismo'),
	('juegos de mesa'),
	('cine'),
	('cartas'),
	('museos'),
	('gastronomia'),
	('manualidades');
	
INSERT INTO Usuarios
VALUES
	('paulb', MD5('an28dres'), 'barzallopa@gmail.com', 1, 'Tetuan', true, true),
	('alvaro', MD5('user2'), 'avillanovaf@gmail.com', 2, 'Latina', true, true),
	('borja', MD5('user3'), 'borja@gmail.com', 2, 'Arganzuela', true, true);
	
INSERT INTO HobbiesUsuarios
VALUES
	('paulb', 3),
	('paulb', 4),
	('paulb', 5),
	('paulb', 6),
	('paulb', 8),
	('alvaro', 1),
	('alvaro', 2),
	('alvaro', 4),
	('borja', 5),
	('borja', 7),
	('borja', 8);
	
INSERT INTO Admins VALUES ('51511038P', '632401379', 'paulb');

INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES (
	"Primer evento de prueba",
	"Suscipit tempor ultricies felis et turpis nec a nunc suscipit ultrices curae volutpat senectus id ante posuere, augue phasellus accumsan suscipit pharetra inceptos tortor viverra maecenas tempor fusce lacus dictumst lacinia.
<b>Volutpat:</b>
<ul>
<li>tempus leo tempor tincidunt cursus morbi sit venenatis</li>
<li>ligula quisque hendrerit aliquam a dolor ut curae</li>
<li>tellus praesent consectetur vehicula pulvinar leo sollicitudin</li>
</ul>",
	'2019-02-04 13:30',
	'Tetuan',
	'c/ falsa, 11 3/4',
	'img/evento1',
	3,
	false,
	true,
	'51511038P');
	
INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES (
	"Segundo evento de prueba",
	"Lobortis ut scelerisque aliquam volutpat hendrerit magna cursus ut urna aenean faucibus, curae blandit ipsum turpis risus euismod cras pellentesque fermentum. Phasellus malesuada facilisis elementum dictum ut eros lacus quisque faucibus elementum, interdum sed curae sagittis luctus ornare egestas adipiscing sollicitudin luctus urna, congue netus fames senectus tellus nulla curabitur sapien donec.
Mauris libero vivamus feugiat nisl egestas semper nibh non ipsum, dolor massa quisque eros sapien ornare amet purus, dapibus iaculis faucibus gravida sociosqu dui placerat etiam. Fames litora tristique felis aenean at vel nibh aptent bibendum, sagittis feugiat sagittis nulla mattis curae tortor habitant, consectetur lacus torquent eros integer et duis aenean.",
	'2019-02-04 11:30',
	'Chamartin',
	'c/ metro viejo, 11 3 B',
	'img/evento2',
	3,
	false,
	true,
	'51511038P');
INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES (
	"Tercer evento de prueba",
	"Pulvinar torquent dui metus eget a platea a, justo feugiat consequat sapien erat ut cras, pulvinar felis scelerisque feugiat facilisis est.",
	'2019-02-06 9:00',
	'Barajas',
	'c/ de los aviones gemelos, 11 9 2001',
	'img/evento3',
	3,
	false,
	true,
	'51511038P');
INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES (
	"Cuarto evento de prueba",
	"Dapibus etiam malesuada diam ut potenti facilisis lorem morbi blandit nec varius, nam ut aenean enim donec justo gravida eleifend magna tempus, ad sem elit.
Auctor tempus integer porta scelerisque donec sagittis. Mauris curabitur sem praesent hendrerit suscipit, purus donec per eu quisque cursus, platea rhoncus scelerisque volutpat.
Quam semper donec aptent egestas blandit suspendisse, quam pretium cursus curabitur lectus adipiscing, proin curabitur ut sem nullam. Netus commodo eros, placerat.",
	'2019-02-10 14:30',
	'Ciudad Lineal',
	'c/ curva, 211 B Der',
	'img/evento4',
	3,
	false,
	true,
	'51511038P');	
	
INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES (
	"Quinto evento de prueba",
	"Dapibus etiam malesuada diam ut potenti facilisis lorem morbi blandit nec varius, nam ut aenean enim donec justo gravida eleifend magna tempus, ad sem elit.
Auctor tempus integer porta scelerisque donec sagittis. diam ut potenti facilisis lorem morbi blandit nec varius, nam ut aenean enim donec justo gravida eleifend sem praesent hendrerit suscipit, purus donec per eu quisque cursus, platea rhoncus scelerisque volutpat.
Quam semper donec aptent egestas blandit suspendisse, quam pretium cursus lectus adipiscing, proin curabitur ut sem nullam.
curabitur lectus adipiscing, proin curabitur ut sem nullam. Netus commodo eros, placerat.",
	'2019-04-10 8:30',
	'Ciudad Lineal',
	'c/ futura, 893 5 Der',
	'img/evento5',
	4,
	false,
	true,
	'51511038P');
	
INSERT INTO HobbiesEventos
VALUES
	(1, 3),
	(1, 5),
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(3, 9),
	(3, 4),
	(3, 6),
	(4, 1),
	(4, 3),
	(4, 5),
	(4, 7),
	(4, 9),
	(5, 6),
	(5, 7);
INSERT INTO Inscritos VALUES ('paulb', 1);
INSERT INTO Inscritos VALUES ('alvaro', 1);
INSERT INTO Inscritos VALUES ('borja', 1);

INSERT INTO Usuarios
INSERT INTO `usuarios` 
VALUES ('adrian','a722c63db8ec8625af6cf71cb8c2d939','adrian@gmail.com',2,'Barajas',0,1),('alberto','a722c63db8ec8625af6cf71cb8c2d939','alberto@gmail.com',1,'Arganzuela',0,1),('almudena','a722c63db8ec8625af6cf71cb8c2d939','almudena@gmail.com',3,'Canillejas',0,1),('alvaro','7e58d63b60197ceb55a1c487989a3720','avillanovaf@gmail.com',2,'Latina',1,1),('borja','92877af70a45fd6a2ed7fe81e1236b78','borja@gmail.com',2,'Arganzuela',1,1),('diana','a722c63db8ec8625af6cf71cb8c2d939','wonderwoman@gmail.com',4,'Carabanchel',0,1),('fabio','a722c63db8ec8625af6cf71cb8c2d939','fabio@gmail.com',5,'Centro',0,1),('gema','a722c63db8ec8625af6cf71cb8c2d939','gema@gmail.com',6,'Chamartin',0,1),('hector','a722c63db8ec8625af6cf71cb8c2d939','troya@gmail.com',1,'Chamberi',0,1),('ines','a722c63db8ec8625af6cf71cb8c2d939','ines@gmail.com',2,'Ciudad Lineal',0,1),('jacinto','a722c63db8ec8625af6cf71cb8c2d939','benavente@plaza.net',3,'Latina',0,1),('jaime','a722c63db8ec8625af6cf71cb8c2d939','jaime@correo.es',3,'Latina',0,1),('jessica','a722c63db8ec8625af6cf71cb8c2d939','jessica@choni.es',2,'Usera',0,1),('jonatan','a722c63db8ec8625af6cf71cb8c2d939','jonatan@telecinco.es',2,'Usera',0,1),('jose','a722c63db8ec8625af6cf71cb8c2d939','jose@masmovil.com',1,'Latina',0,1),('juan','a722c63db8ec8625af6cf71cb8c2d939','yonosenada@gmail.com',2,'El pardo-Fuencarral',0,1),('laura','a722c63db8ec8625af6cf71cb8c2d939','laura@gmail.com',3,'Hortaleza',0,1),('maria','a722c63db8ec8625af6cf71cb8c2d939','maria@gmail.com',3,'Hortaleza',0,1),('nuria','a722c63db8ec8625af6cf71cb8c2d939','nuria@gmail.com',5,'Moncloa',0,1),('oscar','a722c63db8ec8625af6cf71cb8c2d939','oscar@gmail.com',3,'Moratalaz',0,1),('paula','a722c63db8ec8625af6cf71cb8c2d939','paula@gmail.com',2,'Puente de Vallecas',0,1),('paulb','0a73f6f4945f8c3e29324eb0b2c209bb','barzallopa@gmail.com',1,'Tetuan',1,1),('pepe','ee11cbb19052e40b07aac0ca060c23ee','user@gmail.com',1,'Tetuan',0,1),('raul','a722c63db8ec8625af6cf71cb8c2d939','raul@gmail.com',3,'Salamanca',0,1),('sandra','a722c63db8ec8625af6cf71cb8c2d939','sandra@gmail.com',2,'Tetuan',0,1),('sara','a722c63db8ec8625af6cf71cb8c2d939','sarasaritasaramontiel@gmail.com',6,'Tetuan',0,1),('teresa','a722c63db8ec8625af6cf71cb8c2d939','teresa@gmail.com',2,'Usera',0,1),('valentin','a722c63db8ec8625af6cf71cb8c2d939','valentin@gmail.com',4,'Vicalvaro',0,1),('yolanda','a722c63db8ec8625af6cf71cb8c2d939','yolanda@gmail.com',6,'Villa de Vallecas',0,1),('zacarias','a722c63db8ec8625af6cf71cb8c2d939','zacarias@hotmail.com',6,'Villaverde',0,1);

INSERT INTO HobbiesUsuarios
VALUES
	('pepe', 3),
	('pepe', 4),
	('pepe', 5);
