create extension if not exists ltree;
drop table if exists tud;

create table tud (path ltree);

INSERT INTO tud VALUES ('TUD');
INSERT INTO tud VALUES ('TUD.Art');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.ProductDesign');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.FineArts');
INSERT INTO tud VALUES ('TUD.Art.CreativeArts.InteriorDesign');
INSERT INTO tud VALUES ('TUD.Art.Food');
INSERT INTO tud VALUES ('TUD.Art.Food.CulinaryArts');
INSERT INTO tud VALUES ('TUD.Art.Food.Baking');
INSERT INTO tud VALUES ('TUD.Art.Turism');
INSERT INTO tud VALUES ('TUD.Art.Turism.EventManagment');
INSERT INTO tud VALUES ('TUD.Art.Turism.TurismMarketing');
INSERT INTO tud VALUES ('TUD.Art.Languages_Law_SocialScience');
INSERT INTO tud VALUES ('TUD.Art.Languages_Law_SocialScience.InternationaBusinessLanguage');
INSERT INTO tud VALUES ('TUD.Art.Media');
INSERT INTO tud VALUES ('TUD.Art.Media.GameDesign');
INSERT INTO tud VALUES ('TUD.Art.Media.FilmBroadcasting');
INSERT INTO tud VALUES ('TUD.Art.Conservatory');
INSERT INTO tud VALUES ('TUD.Art.Conservatory.Composition');
INSERT INTO tud VALUES ('TUD.Business');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance.BusinessFinance');
INSERT INTO tud VALUES ('TUD.Business.Accounting_Finance.Macroeconomics');
INSERT INTO tud VALUES ('TUD.Business.Marketing');
INSERT INTO tud VALUES ('TUD.Business.Marketing.MarketingPractice');
INSERT INTO tud VALUES ('TUD.Business.Marketing.InternationalMarketing');
INSERT INTO tud VALUES ('TUD.Business.Management');
INSERT INTO tud VALUES ('TUD.Business.Management.Logistics');
INSERT INTO tud VALUES ('TUD.Business.Management.SupplyChainManagement');
INSERT INTO tud VALUES ('TUD.Business.Retail');
INSERT INTO tud VALUES ('TUD.Business.Retail.RetailAnalytics');
INSERT INTO tud VALUES ('TUD.Business.Retail.RetailMarketing');
INSERT INTO tud VALUES ('TUD.Science');
INSERT INTO tud VALUES ('TUD.Science.Pharmaceutical_Chemistry_Forensic.Biotechnology');
INSERT INTO tud VALUES ('TUD.Science.Pharmaceutical_Chemistry_Forensic.BasicMicrobiology');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience.MolecularBiology');
INSERT INTO tud VALUES ('TUD.Science.BiologicalScience.ScientificProject');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition.FoodMicrobiology');
INSERT INTO tud VALUES ('TUD.Science.Food_Nutrition.Food_Beverage');
INSERT INTO tud VALUES ('TUD.Science.HealthCare');
INSERT INTO tud VALUES ('TUD.Science.HealthCare.OpticalDispensing');
INSERT INTO tud VALUES ('TUD.Science.HealthCare.BinocularVision');
INSERT INTO tud VALUES ('TUD.Science.Physics');
INSERT INTO tud VALUES ('TUD.Science.Physics.Relativity');
INSERT INTO tud VALUES ('TUD.Science.Physics.QuantumMechanics');
INSERT INTO tud VALUES ('TUD.Science.Mathematics');
INSERT INTO tud VALUES ('TUD.Science.Mathematics.Geometry');
INSERT INTO tud VALUES ('TUD.Science.Mathematics.RealAnalisys');
INSERT INTO tud VALUES ('TUD.Science.Computing');
INSERT INTO tud VALUES ('TUD.Science.Computing.Databases');
INSERT INTO tud VALUES ('TUD.Science.Computing.CloudComputing');
INSERT INTO tud VALUES ('TUD.Engineering');
INSERT INTO tud VALUES ('TUD.Engineering.BuiltEngineering.AutomitiveManagement');
INSERT INTO tud VALUES ('TUD.Engineering.BuiltEngineering.PropertyStudies');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture.ArchitecturalTechnology');
INSERT INTO tud VALUES ('TUD.Engineering.Architecture.ConstrutionStieManagement');
INSERT INTO tud VALUES ('TUD.Engineering.StructuralEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.StructuralEngineering.CivilEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology.Modelling');
INSERT INTO tud VALUES ('TUD.Engineering.MultidisciplinaryTechnology.BIM');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering.ElectricalPower');
INSERT INTO tud VALUES ('TUD.Engineering.ElectronicalEngineering.Control');
INSERT INTO tud VALUES ('TUD.Engineering.Transport');
INSERT INTO tud VALUES ('TUD.Engineering.Transport.SpatialPlanning');
INSERT INTO tud VALUES ('TUD.Engineering.Transport.LocalDevelopment');
INSERT INTO tud VALUES ('TUD.Engineering.Design');
INSERT INTO tud VALUES ('TUD.Engineering.Design.DesignInnovation');
INSERT INTO tud VALUES ('TUD.Engineering.Design.CreativeDesignStudio');
INSERT INTO tud VALUES ('TUD.Engineering.Pippo.pdf');


CREATE INDEX path_gist_idx ON tud USING gist(path);
CREATE INDEX path_idx ON tud USING btree(path);

--MEANING of the tree:
-- TUD is the root
-- College is at level 2
-- School at level 3
-- Degrees as level 4

SELECT * FROM tud;
-- subpath(field, offset): return a subpath of ltree field starting from an offset (count starts from zero)
-- nlevel(field): number of level in path
-- field1 <@ field2: return if field1 is a descendant of field2

-- show all paths from the 4th node of length 4, descendant of 'TUD.ART' (=school of art)
--the qury show all the degrees of the school of ART
SELECT subpath(path, 3) FROM tud WHERE path <@ 'TUD.Art' and nlevel(path)=4;

-- select the root node 
SELECT subpath(path,0,1) FROM tud where nlevel(path)=1;

--what is this query doing?
--it counts the schools for each college
SELECT subpath(path,1,1) AS "College",count(subpath(path,2,1)) AS "Number of Schools"
FROM tud
WHERE nlevel(path) = 3								   
GROUP BY subpath(path,1,1);

--Explanation:
--select the name of the College with subpath(path,1,1): so getting Art from TUD.Art.CreativeArts)
--select name of Schools with subpath(path,2,1): so getting CreativeArts from TUD.Art.CreativeArts)
--fiter path with 3 elements with nlevel(path) = 3
--group by College name with subpath(path,1,1)
------------------------------------------------------------------------------------------------------------------
--Exercise 1
--add the Computer Science under the Science College level and added the software & AI degrees
insert into tud values ('TUD.Science.Computer_Science');
insert into tud values ('TUD.Science.Computer_Science.Software');
insert into tud values ('TUD.Science.Computer_Science.AI');

--create queries
--a: Find the immediate route of MolecularBiology
select subpath(path, 2, 1) AS "School" from tud where path ~'*.MolecularBiology';

--b: Count all degrees
select count(*)from tud where nlevel(path) = 4;

--c: find the college with the most degrees
select subpath(path, 1, 1) as "College", COUNT(*) as "Number of Degrees"
from tud where nlevel(path) = 4
group by subpath(path, 1, 1) order by "Number of Degrees" desc
limit 1;

--d: How many colleges exist?
select count(distinct subpath(path, 1, 1)) as "Number of Colleges"
from tud where nlevel(path) >= 2;

--e: TUD renamed to TUDublin and all paths follow
update tud set path = subpath(path, 0)::ltree || 'TUDublin'
where path ~'*.TUD.*';

--f: Biological Science and its children are deleted
delete from tud where path <@'TUD.Science.BiologicalScience';

--g: Add CAO points column
alter table tud add column CAO_points integer;

--h
update tud
set CAO_points = case 
		when path ~ 'TUD.Art.*' then 300
	    when path ~ 'TUD.Science.*' then 450
	    when path ~ 'TUD.Engineering.*' then 400
	    else 350
	end
where nlevel(path) = 4;

--i
update tud
set CAO_points = 500 where path ~ 'TUD.Science.Computer_Science.*';

--j
select avg(CAO_points) as "Average CAO points"
from tud where path ~'TUD.Science.*' and nlevel(path) = 4;







