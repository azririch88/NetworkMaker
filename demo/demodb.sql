DROP TABLE NodeTree;
CREATE TABLE NodeTree (
    ID      INT(8) NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE Node;
CREATE TABLE Node (
    Tree    INT(8) NOT NULL,
    ID      INT(8) NOT NULL,
    Data    BLOB,
    PRIMARY KEY (Tree, ID),
    FOREIGN KEY (Tree) REFERENCES NodeTree (ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE Socket;
CREATE TABLE Socket (
    Tree    INT(8) NOT NULL,
    Node    INT(8) NOT NULL,
    ID      INT(8) NOT NULL,
	Input	INT(1) NOT NULL,
    Data    BLOB,
    PRIMARY KEY (Tree, Node, ID, Input),
    FOREIGN KEY (Tree) REFERENCES NodeTree (ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Node) REFERENCES Node (ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE Link;
CREATE TABLE Link (
    Tree        INT(8) NOT NULL,
    ToNode      INT(8) NOT NULL,
    ToSocket    INT(8) NOT NULL,
    FromNode    INT(8) NOT NULL,
    FromSocket  INT(8) NOT NULL,
    Data        BLOB,
    PRIMARY KEY (Tree, ToNode, ToSocket, FromNode, FromSocket),
    FOREIGN KEY (Tree) REFERENCES NodeTree (ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ToNode) REFERENCES Node (ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ToSocket) REFERENCES Socket (ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FromNode) REFERENCES Node (ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FromSocket) REFERENCES Socket (ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

insert into NodeTree values (0);

insert into Node values (0, 0, "");
insert into Node values (0, 1, "");
insert into Node values (0, 2, "");

insert into Socket values (0, 0, 0, 1, "");
insert into Socket values (0, 0, 1, 1, "");
insert into Socket values (0, 0, 0, 0, "");
insert into Socket values (0, 1, 0, 1, "");
insert into Socket values (0, 1, 1, 1, "");
insert into Socket values (0, 1, 0, 0, "");
insert into Socket values (0, 2, 0, 1, "");
insert into Socket values (0, 2, 1, 1, "");
insert into Socket values (0, 2, 0, 0, "");

insert into Link values (0, 2, 0, 0, 0, "");
insert into Link values (0, 2, 1, 1, 0, "");