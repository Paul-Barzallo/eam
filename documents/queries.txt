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
VALUES ('pepe', MD5('user'), 'user@gmail.com', 1, 'Tetuan', false, true);
INSERT INTO HobbiesUsuarios
VALUES
	('pepe', 3),
	('pepe', 4),
	('pepe', 5);