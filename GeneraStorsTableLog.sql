--Genera Stors V 1.0
Begin
Declare @Table  varchar(100) = 'TableName'
Declare @Column nvarchar(128),@DataType nvarchar(128),@MaxCharacters int
Declare cTable Cursor For 
Select 
	s.COLUMN_NAME,
	s.DATA_TYPE,
	s.CHARACTER_MAXIMUM_LENGTH
From 
	INFORMATION_SCHEMA.COLUMNS s
Where s.TABLE_NAME = @Table

--Crear Insert
Print 'Create Procedure SPI_'+@Table

open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print ' @'+@Column + ' ' + @DataType + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print ' @Id int out'
Print 'As'
Print 'Begin'

Print ' Insert Into'
Print ' ' + @Table
Print ' ('
open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print '  '+@Column + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print ' )'
Print ' Values'
Print ' ('

open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print '  @'+@Column + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print ' )'
Print 'Set @Id = SCOPE_IDENTITY()'
Print 'End'

Print '--   Actualiza   --'
Print 'SPU_' + @Table
open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print ' @'+@Column + ' ' + @DataType + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print 'As'
Print 'Begin'

Print ' Update ' + @Table
Print ' Set'

open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print '  '+@Column + ' = @' +@Column + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print ' Where '
Print 'End'

Print '--   Obtener elemento unico   --'
Print 'Create Procedure SPS_'+ @Table + 'Id'
Print ' @Id int'
Print 'As'
Print 'Begin'
Print ' Select'

open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
While @@FETCH_STATUS = 0
Begin
 Print '  '+@Column + ','
 Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
End
Close cTable
Print ' From ' 
Print '  ' + @Table
Print ' Where'

open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
Print '  '+@Column + ' = @Id'
Close cTable
Print 'End'

Print '--   Eliminar   --'
Print 'Create Procedure SPD_'+@Table
Print '@Id int'
Print 'As'
Print 'Begin'
Print ' Delete From ' +@Table
Print ' Where'
open cTable
Fetch Next From cTable Into @Column,@DataType, @MaxCharacters
Print '  '+@Column + ' = @Id'
Close cTable

Print 'End'
DEALLOCATE cTable

End
