

use R17MRL1

Declare @TblNm varchar(max)
		,@Column varchar(max)

/*Insert table or column search between %% in set statement*/
Set @TblNm = '%%'
Set @Column = '%Coupon%'
print @TblNm
print @Column

select Table_Name,Column_Name,Data_Type, Character_Maximum_Length
from INFORMATION_SCHEMA.COLUMNS
where 
table_name like @TblNm
and column_name like @Column
order by table_Name,Column_Name

