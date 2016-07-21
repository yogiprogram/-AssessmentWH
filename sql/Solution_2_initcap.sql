DELIMITER  $$ 
drop function if exists initcap $$
create function initcap( inputstring varchar(255)) returns varchar(255)
deterministic
begin
  declare ret varchar(255);
  set ret = '';
  set inputstring = concat(lower(inputstring), ' ');
  WHILE (LOCATE(' ', inputstring) > 0)
  DO
    set ret = concat(
				ret, ' ', CONCAT(UCASE(LEFT(LEFT(inputstring, LOCATE(' ',inputstring) - 1), 1)), 
				SUBSTRING(LEFT(inputstring, LOCATE(' ',inputstring) - 1), 2)) );
	SET inputstring = SUBSTRING(inputstring, LOCATE(' ',inputstring) + 1);
  END WHILE;
    return ret;
end 
$$
DELIMITER ;


/* Testing */
SELECT initcap("UNITED states Of AmERIca");