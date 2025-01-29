-- PLAN OBJECTIVES CALCULATOR
SELECT
	p.name AS PlanName,
    o.name AS ObjectiveName,
    CEILING(p.nbChickens * 1.0/ o.perNbChicken) * o.goal AS toReach,
    o.unit
FROM objective o
INNER JOIN plan_objectives po ON o.id_objective = po.id_objective
INNER JOIN plan p ON po.id_plan = p.id_plan;

