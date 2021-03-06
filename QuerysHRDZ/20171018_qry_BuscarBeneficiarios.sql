

/* BUSQUEDA DE BENEFICIARIO */
select a.AsuntoBeneficiario,b.id_chequera,b.desc_chequera,id_banco
from lrs..v_Cat_Ctas_Beneficiarios a
left  join [sethdzqa]..[cat_cta_banco] b on cast(cast(a.AsuntoBeneficiario as bigint) as varchar(25))=b.id_chequera collate Modern_Spanish_CI_AS
order by 3 asc

select  descripcion, SUM(existe)existe, SUM(noexiste)noexiste
from (
		select
		case when b.id_chequera IS null then 'NO EXISTE' 			 ELSE 'EXISTE' 		end descripcion
		, case when b.id_chequera IS null then 1 else 0 end as noexiste
		, case when b.id_chequera IS not null then  1 else 0 end existe
		from lrs..v_Cat_Ctas_Beneficiarios a
		left  join [sethdzqa]..[cat_cta_banco] b on cast(cast(a.AsuntoBeneficiario as bigint) as varchar(25))=b.id_chequera collate Modern_Spanish_CI_AS
)t1
group by descripcion


select a.AsuntoBeneficiario,b.id_chequera,b.desc_chequera,id_banco
from lrs..v_Cat_Ctas_Beneficiarios a
left  join [sethdzqa]..ctas_banco b on cast(cast(a.AsuntoBeneficiario as bigint) as varchar(25))=b.id_chequera collate Modern_Spanish_CI_AS
WHERE 1=1
order by 3 asc

select descripcion , count(existe)existe, COUNT(noexiste)noexiste
FROM (
		select case when b.id_chequera IS null then 'NO EXISTE'		ELSE 'EXISTE' END descripcion
		, case when b.id_chequera IS null then 1 end as noexiste
		, case when b.id_chequera IS not null then  1 end existe
		from lrs..v_Cat_Ctas_Beneficiarios a
		left  join [sethdzqa]..ctas_banco b on cast(cast(a.AsuntoBeneficiario as bigint) as varchar(25))=b.id_chequera collate Modern_Spanish_CI_AS
)T1
group by descripcion


select 
		t1.AsuntoBeneficiario
		,t1.cta_int
		,t2.cta_int as cta_cat 
from 
			(
			select  distinct  AsuntoBeneficiario
			,cast(CAST( AsuntoBeneficiario as numeric(25))  as varchar(25)) cta_int
			from LRS..v_Cat_Ctas_Beneficiarios
			
			) t1
left join (
			SELECT   
			  id_chequera 
			, cast(CAST( id_chequera as numeric(25))  as varchar(25)) cta_int
			FROM ctas_banco 
			WHERE 1=1 
			and id_chequera not like '%[a-z]%' 
			and id_chequera not like '%[A-Z]%'
			and id_chequera<>''
			group by  id_chequera
		   ) t2 
		on t1.cta_int=t2.cta_int
order by 1





