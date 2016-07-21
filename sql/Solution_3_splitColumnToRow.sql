DROP PROCEDURE IF EXISTS splitcolumntorow;

DELIMITER ||  

CREATE PROCEDURE splitcolumntorow(IN rownumber INT) 
BEGIN  
    
    DECLARE found INT DEFAULT 0;  
    DECLARE value VARCHAR(50);
    
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE count INT DEFAULT 1;
	DECLARE cursor_names 
		CURSOR FOR SELECT NAME  FROM sometbl  WHERE id = rownumber;
		
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	
	
	
    DROP TEMPORARY TABLE IF EXISTS tempTable;
	
    CREATE TEMPORARY TABLE tempTable (ID INT, NAME VARCHAR(50));    

    OPEN cursor_names;

    process_names: LOOP
        FETCH cursor_names INTO value;

        if finished = 1 THEN
            LEAVE process_names;
        END IF;

        WHILE count = 1 DO  
            BEGIN  
            SET found = INSTR(value, '|');
            IF found = 0 THEN
                BEGIN
					INSERT INTO tempTable  VALUES (rownumber, value);
					SET count = 0;
                END;
            ELSE 
                BEGIN
					INSERT INTO tempTable VALUES (rownumber, SUBSTRING(value, 1, found - 1));
					SET value = SUBSTRING(value, found + 1);
                END;
            END IF;
            END;  
        END WHILE;  
    END LOOP;
  SELECT * FROM tempTable WHERE id = rownumber;
  DROP TEMPORARY TABLE IF EXISTS tempTable;
END ||  

DELIMITER ; 

CALL getNames(3);


