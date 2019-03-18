SET GLOBAL time_zone = '+1:00';

DROP DATABASE IF EXISTS eam;

DROP USER IF EXISTS 'adminEAM'@'localhost';
CREATE USER 'adminEAM'@'localhost' identified by 'conecta';
GRANT ALL PRIVILEGES ON eam.* TO adminEAM@localhost;
FLUSH PRIVILEGES;

CREATE database eam;
USE eam;

# CREACION DE TABLAS
CREATE TABLE Usuarios ( 
	id_usuario VARCHAR(20) PRIMARY KEY,
	password VARCHAR(32) NOT NULL,
	email VARCHAR(80) NOT NULL UNIQUE,
	rango_edad INT NOT NULL,
	barrio VARCHAR(30) NOT NULL,
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
	titulo VARCHAR(60) NOT NULL,
	descripcion VARCHAR(1000) NOT NULL,
	fecha DATETIME NOT NULL,
	barrio VARCHAR(30) NOT NULL,
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

# INSERCION DE DATOS

# Insercion de hobbies
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
	
INSERT INTO Admins VALUES ('51511038P', '632401379', 'paulb');
INSERT INTO Admins VALUES ('11111111X', '643534535', 'alvaro');
INSERT INTO Admins VALUES ('22222222Y', '645634532', 'borja');

INSERT INTO Usuarios
VALUES 	
	('adrian','a722c63db8ec8625af6cf71cb8c2d939','adrian@gmail.com',2,'Barajas',0,1),
	('alberto','a722c63db8ec8625af6cf71cb8c2d939','alberto@gmail.com',1,'Arganzuela',0,1),
	('almudena','a722c63db8ec8625af6cf71cb8c2d939','almudena@gmail.com',3,'Canillejas',0,1),
	('diana','a722c63db8ec8625af6cf71cb8c2d939','wonderwoman@gmail.com',4,'Carabanchel',0,1),
	('fabio','a722c63db8ec8625af6cf71cb8c2d939','fabio@gmail.com',5,'Centro',0,1),
	('gema','a722c63db8ec8625af6cf71cb8c2d939','gema@gmail.com',6,'Chamartin',0,1),
	('hector','a722c63db8ec8625af6cf71cb8c2d939','troya@gmail.com',1,'Chamberi',0,1),
	('ines','a722c63db8ec8625af6cf71cb8c2d939','ines@gmail.com',2,'Ciudad Lineal',0,1),
	('jacinto','a722c63db8ec8625af6cf71cb8c2d939','benavente@plaza.net',3,'Latina',0,1),
	('jaime','a722c63db8ec8625af6cf71cb8c2d939','jaime@correo.es',3,'Latina',0,1),
	('jessica','a722c63db8ec8625af6cf71cb8c2d939','jessica@choni.es',2,'Usera',0,1),
	('jonatan','a722c63db8ec8625af6cf71cb8c2d939','jonatan@telecinco.es',2,'Usera',0,1),
	('jose','a722c63db8ec8625af6cf71cb8c2d939','jose@masmovil.com',1,'Latina',0,1),
	('juan','a722c63db8ec8625af6cf71cb8c2d939','yonosenada@gmail.com',2,'El pardo-Fuencarral',0,1),
	('laura','a722c63db8ec8625af6cf71cb8c2d939','laura@gmail.com',3,'Hortaleza',0,1),
	('maria','a722c63db8ec8625af6cf71cb8c2d939','maria@gmail.com',3,'Hortaleza',0,1),
	('nuria','a722c63db8ec8625af6cf71cb8c2d939','nuria@gmail.com',5,'Moncloa',0,1),
	('oscar','a722c63db8ec8625af6cf71cb8c2d939','oscar@gmail.com',3,'Moratalaz',0,1),
	('paula','a722c63db8ec8625af6cf71cb8c2d939','paula@gmail.com',2,'Puente de Vallecas',0,1),
	('pepe','ee11cbb19052e40b07aac0ca060c23ee','user@gmail.com',1,'Tetuan',0,1),
	('raul','a722c63db8ec8625af6cf71cb8c2d939','raul@gmail.com',3,'Salamanca',0,1),
	('sandra','a722c63db8ec8625af6cf71cb8c2d939','sandra@gmail.com',2,'Tetuan',0,1),
	('sara','a722c63db8ec8625af6cf71cb8c2d939','sarasaritasaramontiel@gmail.com',6,'Tetuan',0,1),
	('teresa','a722c63db8ec8625af6cf71cb8c2d939','teresa@gmail.com',2,'Usera',0,1),
	('valentin','a722c63db8ec8625af6cf71cb8c2d939','valentin@gmail.com',4,'Vicalvaro',0,1),
	('yolanda','a722c63db8ec8625af6cf71cb8c2d939','yolanda@gmail.com',6,'Villa de Vallecas',0,1),
	('zacarias','a722c63db8ec8625af6cf71cb8c2d939','zacarias@hotmail.com',6,'Villaverde',0,1);

INSERT INTO hobbiesusuarios
VALUES ('paulb',3),
	('paulb',4),('paulb',5),('paulb',6),('paulb',8),
	('alvaro',1),('alvaro',2),('alvaro',4),
	('borja',5),('borja',7),('borja',8),
	('pepe',3),('pepe',4),('pepe',5),
	('alberto',6),('alberto',7),
	('adrian',1),('adrian',4),
	('almudena',2),('almudena',7),
	('diana',2),('diana',5),
	('fabio',2),('fabio',5),
	('gema',3),('gema',6),
	('hector',1),('hector',2),('hector',3),
	('ines',5),('ines',8),
	('juan',3),('juan',7),('juan',9),
	('laura',4),('laura',6),
	('maria',2),('maria',5),
	('nuria',2),('nuria',3),('nuria',7),
	('oscar',1),('oscar',6),('oscar',7),
	('paula',5),('paula',7),
	('raul',1),('raul',6),
	('sandra',8),('sandra',9),
	('teresa',3),('teresa',4),
	('valentin',4),('valentin',5),('valentin',7),
	('yolanda',3),('yolanda',5),('yolanda',7),('yolanda',8),
	('zacarias',3),('zacarias',7),('zacarias',8),
	('jose',5),
	('jaime',3),('jaime',6),
	('jacinto',3),('jacinto',5),
	('sara',5),('sara',7),
	('jonatan',1),('jonatan',5),
	('jessica',5),('jessica',8);

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
	"Timba de poker en el Museo Nacional",
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

INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Baloncesto",
		"Pasaremos un fin de semana lleno de actividad practicando uno de los deportes mas famosos del mundo. Lorem ipsum dolor sit amet consectetur adipiscing elit molestie mattis, feugiat ad vestibulum auctor sociis blandit erat magna potenti, habitant malesuada morbi gravida platea commodo pellentesque vel. Dapibus accumsan ligula aliquam viverra tellus ac bibendum metus phasellus auctor curabitur, odio vestibulum dignissim placerat lectus fusce arcu donec eget tempor egestas, inceptos taciti venenatis congue malesuada mus hendrerit turpis habitasse duis. Rhoncus mauris convallis ut bibendum hac primis sapien velit euismod quisque pulvinar, varius cursus natoque risus blandit ullamcorper sociis maecenas cras.",
		'2019-03-24 11:30:00',
		'Arganzuela',
		'Paseo de las Delicias, 61, 28045 Madrid',
		'img/evento6',
		2,
		false,
		true,
		'51511038P');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Partido de Fútbol 5x5",
		"Ven a jugar un 5 contra 5 y demuestra quién manda en la cancha. Lorem ipsum dolor sit amet consectetur adipiscing elit morbi massa porta eleifend iaculis, justo arcu luctus lobortis posuere torquent ridiculus ullamcorper mauris taciti. Scelerisque gravida aenean habitasse cras dictumst bibendum netus, torquent congue odio inceptos quam tempor senectus vivamus, elementum est purus faucibus commodo felis. Hendrerit ultricies turpis per vitae sem eros duis fames pretium habitant, hac dapibus eleifend tempus inceptos lacinia tincidunt class imperdiet proin, maecenas felis fermentum mollis enim lectus purus potenti eu. Non tempus urna erat faucibus pulvinar molestie varius posuere sagittis, habitasse natoque mattis ridiculus congue dictum porttitor fermentum id, lectus aptent curae proin pharetra eleifend mus commodo.",
		'2019-04-04 17:30:00',
		'Barajas',
		'C/ Vía Dublín, 2I, 28042 Madrid',
		'img/evento7',
		2,
		false,
		true,
		'11111111X');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Ruta de Senderismo",
		"Coge tracción porque va a ser un día de caminata y campo. Lorem ipsum dolor sit amet consectetur adipiscing elit, platea ligula class fermentum rhoncus hendrerit etiam eget, fusce vestibulum in ornare tempor bibendum. Duis mus felis faucibus nibh hendrerit etiam cras ornare, eleifend vivamus dui cubilia dignissim justo platea, velit lobortis nullam inceptos fringilla sem ante. Rhoncus accumsan ultricies vehicula aliquet ac eros vitae urna, nunc malesuada est et congue id morbi tortor sagittis, cursus suspendisse duis sollicitudin nullam condimentum molestie.",
		'2019-04-10 12:00:00',
		'Canillejas',
		'Calle del Canal del Bósforo, 82',
		'img/evento8',
		2,
		false,
		true,
		'22222222Y');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Visita al Museo de Ciencias Naturales",
		"Dinosaurios, planetas y curiosidades...¿Te lo vas a perder?. Lorem ipsum dolor sit amet consectetur adipiscing elit risus habitasse class, magna consequat leo dignissim nostra pellentesque sed eros. Natoque conubia phasellus nascetur suspendisse cubilia mattis, senectus duis parturient nisi blandit varius, porttitor sed id at convallis. Convallis phasellus maecenas donec nisi justo posuere tortor, fermentum cubilia litora nam curae commodo volutpat cras, quisque vel duis sagittis gravida pharetra.",
		'2019-04-12 10:30:00',
		'Chamartin',
		'Calle de José Gutiérrez Abascal, 2, 28006 Madrid',
		'img/evento9',
		2,
		false,
		true,
		'51511038P');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Cocina contra el hambre",
		"Sientete chef y compite por una buena causa. Lorem ipsum dolor sit amet consectetur adipiscing, elit ligula rhoncus volutpat magnis leo porta, non justo porttitor congue at. Nisl pharetra felis accumsan taciti nulla id tempus dis dui, blandit donec per litora mi aptent eget sollicitudin quam, hendrerit odio egestas neque diam libero sociosqu placerat. Vehicula sociosqu eget orci semper parturient lectus fermentum tellus, senectus ut aenean scelerisque leo interdum tristique fusce, eu venenatis gravida curae netus habitasse facilisis. Habitasse facilisi mus rhoncus eget donec himenaeos sagittis lobortis volutpat at morbi cum lectus leo maecenas, integer posuere hac quam eleifend risus justo in porttitor vestibulum inceptos ultrices vitae.",
		'2019-09-16 01:00:00',
		'Ciudad Lineal',
		'Calle Juan Perez Zuñiga, 25, 28027 Madrid',
		'img/evento10',
		2,
		false,
		true,
		'11111111X');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Cine MARVEL",
		"Tarde de proyecciones de Superhéroes. Eu mi montes erat ullamcorper sapien ornare quam porttitor torquent sem purus cras dapibus tortor, turpis vivamus lacinia neque platea sollicitudin fames conubia netus in vitae cum feugiat. Est rutrum malesuada per diam aliquam molestie nibh conubia mollis phasellus congue, senectus tempus blandit magnis condimentum pharetra pellentesque turpis dapibus. Convallis condimentum imperdiet mollis sociosqu, dui habitant curabitur dictum, primis viverra molestie.",
		'2019-05-07 18:00:00',
		'Chamberi',
		'Calle de Fuencarral, 136, 28001 Madrid',
		'img/evento11',
		2,
		false,
		true,
		'22222222Y');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Taller de Manualidades",
		"Aprende a esculpir tus primeras figuras de barro. Eu mi montes erat ullamcorper sapien ornare quam porttitor torquent sem purus cras dapibus tortor, turpis vivamus lacinia neque platea sollicitudin fames conubia netus in vitae cum feugiat. Est rutrum malesuada per diam aliquam molestie nibh conubia mollis phasellus congue, senectus tempus blandit magnis condimentum pharetra pellentesque turpis dapibus. Convallis condimentum imperdiet mollis sociosqu, dui habitant curabitur dictum, primis viverra molestie.",
		'2019-10-10 18:00:00',
		'Fuencarral - El Pardo',
		'Calle Musgo, 2, 28023 Madrid',
		'img/evento12',
		2,
		false,
		true,
		'51511038P');


INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Magía con Cartas",
    	"En este taller aprenderemos como hacer trucos de magía con cartas. La magia es el arte del ilusionismo que consiste en la habilidad de crear trucos que dan la ilusión de manipular objetos, situaciones o personas de forma que la lógica no puede llegar a entender. Los actos de magia son compuestos por trucos de magia, dentro de los más comunes está la magia con las cartas.",
    	'2019-06-04 19:00:00',
    	'Hortaleza',
    	'Avenida del Papa Negro 60, 28043, Madrid',
    	'img/evento13',
    	2,
    	false,
    	true,
    	'11111111X');


INSERT INTO Eventos
	(titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Taller de Manualidades",
		"Aprende a esculpir tus primeras figuras de barro. Lorem ipsum dolor sit amet consectetur adipiscing elit dis mattis duis congue sapien, ridiculus auctor conubia nam etiam venenatis luctus at sem sodales. Sollicitudin dignissim aliquam nostra platea quis consequat mollis habitant, tempor volutpat aptent vulputate gravida molestie fames. Cras tellus fusce metus interdum mollis neque netus suscipit himenaeos blandit quam, nullam per eleifend cursus fames ultricies taciti mauris euismod. Pulvinar dapibus quisque maecenas donec nullam, in a laoreet justo.",
		'2019-08-07 14:00:00',
		'Chamberi',
		'C/ Santa Engracia 23, 28023 Madrid',
		'img/evento14',
		2,
		false,
		true,
		'22222222Y');
		
INSERT INTO Eventos
	(titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Visita al museo del Prado + Concurso QUIZ",
		"Eu mi montes erat ullamcorper sapien ornare quam porttitor torquent sem purus cras dapibus tortor, turpis vivamus lacinia neque platea sollicitudin fames conubia netus in vitae cum feugiat. Est rutrum malesuada per diam aliquam molestie nibh conubia mollis phasellus congue, senectus tempus blandit magnis condimentum pharetra pellentesque turpis dapibus. Convallis condimentum imperdiet mollis sociosqu, dui habitant curabitur dictum, primis viverra molestie.",
		'2019-03-22 18:00:00',
		'Moratalaz',
		'Calle del Vinateros 104, 28030 Madrid',
		'img/evento15',
		2,
		false,
		true,
		'51511038P');

INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Tarde TERRORIFICA",
		"Ven a disfrutar de una tarde de miedo y vive una experiencia terrorificamente inolvidable. Lorem ipsum dolor sit amet consectetur adipiscing, elit ligula rhoncus volutpat magnis leo porta, non justo porttitor congue at. Nisl pharetra felis accumsan taciti nulla id tempus dis dui, blandit donec per litora mi aptent eget sollicitudin quam, hendrerit odio egestas neque diam libero sociosqu placerat. Vehicula sociosqu eget orci semper parturient lectus fermentum tellus, senectus ut aenean scelerisque leo interdum tristique fusce, eu venenatis gravida curae netus habitasse facilisis. Habitasse facilisi mus rhoncus eget donec himenaeos sagittis lobortis volutpat at morbi cum lectus leo maecenas, integer posuere hac quam eleifend risus justo in porttitor vestibulum inceptos ultrices vitae.",
		'2019-05-24 18:00:00',
		'Vicalvaro',
		'Av. de la Gran Vía del Este, 1, 28032 Madrid',
		'img/evento16',
		3,
		false,
		true,
		'11111111X');

INSERT INTO Eventos (titulo, descripcion, fecha, barrio, direccion, ruta_img, num_img, cancelado, aprobado, id_creador)
VALUES ("Pasados por Agua",
		"Excursion a Valencia, donde disfrutaremos de un fin de se demana de sol y agua y nos iniciaremos en el mundo de la fotografía submarina. Lorem ipsum dolor sit amet consectetur adipiscing elit dis mattis duis congue sapien, ridiculus auctor conubia nam etiam venenatis luctus at sem sodales. Sollicitudin dignissim aliquam nostra platea quis consequat mollis habitant, tempor volutpat aptent vulputate gravida molestie fames. Cras tellus fusce metus interdum mollis neque netus suscipit himenaeos blandit quam, nullam per eleifend cursus fames ultricies taciti mauris euismod. Pulvinar dapibus quisque maecenas donec nullam, in a laoreet justo.",
		'2019-06-07 14:00:00',
		'Villaverde',
		'C/ Santa Engracia 23, 28023 Madrid',
		'img/evento14',
		2,
		false,
		true,
		'22222222Y');
	
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
	(5, 7),
	(6, 2),
	(7, 1),
	(8, 3),
	(9, 7),
	(10, 8),
	(11, 5),
	(12, 9),
	(13, 6),
	(14, 9),
	(15, 7),
	(15, 9);
	
INSERT INTO Inscritos
VALUES 
	('paulb', 1),
	('paulb', 2),
	('paulb', 3),
	('paulb', 4),
	('paulb', 5),
	('paulb', 6),
	('paulb', 7),
	('paulb', 8),
	('paulb', 9),
	('paulb', 10),
	('paulb', 11),
	('paulb', 12),
	('paulb', 13),
	('paulb', 14),
	('paulb', 15),
	('alvaro',2),
	('alvaro',5),
	('alvaro',11),
	('alvaro',12),
	('borja',1),
	('borja',7),
	('borja',9),
	('borja',10),
	('adrian',9),
	('adrian',11),
	('adrian',12),
	('alberto',3),
	('alberto',4),
	('alberto',5),
	('alberto',8),
	('alberto',12),
	('alberto',14),
	('almudena',1),
	('almudena',4),
	('almudena',9),
	('almudena',10),
	('almudena',11),
	('almudena',14),
	('almudena',15),
	('diana',6),
	('diana',9),
	('diana',11),
	('diana',13),
	('diana',14),
	('diana',15),
	('fabio',3),
	('fabio',4),
	('fabio',5),
	('fabio',7),
	('gema',1),
	('gema',8),
	('gema',12),
	('hector',1),
	('hector',5),
	('hector',6),
	('hector',10),
	('ines',1),
	('ines',4),
	('ines',11),
	('ines',14),
	('jacinto',1),
	('jacinto',2),
	('jacinto',3),
	('jacinto',6),
	('jacinto',10),
	('jacinto',13),
	('jaime',3),
	('jaime',9),
	('jaime',10),
	('jaime',15),
	('jessica',7),
	('jessica',8),
	('jessica',9),
	('jessica',10),
	('jessica',11),
	('jonatan',1),
	('jonatan',4),
	('jonatan',6),
	('jonatan',9),
	('jonatan',10),
	('jonatan',12),
	('jose',11),
	('jose',14),
	('juan',3),
	('juan',15),
	('laura',1),
	('laura',3),
	('laura',4),
	('laura',11),
	('laura',12),
	('laura',13),
	('maria',2),
	('maria',4),
	('nuria',10),
	('nuria',12),
	('nuria',15),
	('oscar',1),
	('oscar',8),
	('oscar',9),
	('oscar',14),
	('oscar',15),
	('paula',15),
	('pepe',4),
	('pepe',7),
	('pepe',14),
	('raul',2),
	('raul',3),
	('raul',8),
	('raul',13),
	('raul',14),
	('raul',15),
	('sandra',2),
	('sandra',4),
	('sandra',6),
	('sandra',7),
	('sandra',8),
	('sandra',11),
	('sandra',13),
	('sara',1),
	('sara',2),
	('sara',4),
	('sara',7),
	('sara',8),
	('sara',10),
	('sara',13),
	('teresa',1),
	('teresa',3),
	('teresa',4),
	('teresa',6),
	('teresa',10),
	('teresa',12),
	('teresa',14),
	('valentin',4),
	('valentin',7),
	('valentin',14),
	('yolanda',2),
	('yolanda',4),
	('yolanda',6),
	('yolanda',9),
	('yolanda',12),
	('yolanda',14),
	('zacarias',5),
	('zacarias',14),
	('zacarias',15);