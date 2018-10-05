/* ---------------------------------------------- */
select distinct a.FUNCID, a.FUNCNAME, a.FUNCDESC, a.FUNCGROUPID, b.TTYPE, c.rulesetid, e.statusname, e.STATUSDESC
from GERARD.RBAC_FUNCTIONMANIFEST a,
    GERARD.OPERATION_CONFIG b,
    GERARD.OPERATION_VALID_REL c,
    GERARD.RBAC_STATUSMANIFEST e
where b.FUNCNAME = a.FUNCNAME
and a.FUNCGROUPID = e.FUNCGROUPID
and b.FUNCGROUPID = a.FUNCGROUPID
and b.OPID = c.OPID
--and a.funcgroupid = 'LCI'
and a.funcid = 'FU02101I'
and lower(e.STATUSDESC) like '%new%'
;

select a.FUNCID, a.FUNCNAME, a.FUNCDESC, a.FUNCGROUPID, e.*
from GERARD.RBAC_FUNCTIONMANIFEST a,
    GERARD.RBAC_STATUSMANIFEST e
where a.FUNCGROUPID = e.FUNCGROUPID
--and a.funcgroupid = 'LCI'
and a.funcid = 'FU02101I'
--and 

;

/* ----------------------- */
/* Find RULSETID by FUNCID */
/* ----------------------- */

select a.FUNCID, a.FUNCNAME, a.FUNCDESC, a.FUNCGROUPID, b.OPID, b.NEXTSTATUSID, b.TTYPE, c.rulesetid, c.EXPRESSION
from GERARD.RBAC_FUNCTIONMANIFEST a,
    GERARD.OPERATION_CONFIG b,
    GERARD.OPERATION_VALID_REL c
where b.FUNCNAME = a.FUNCNAME
and b.FUNCGROUPID = a.FUNCGROUPID
and b.OPID = c.OPID
--and a.funcgroupid = 'LCI'
and a.funcid = 'FU02101I'

;

/* ---------------------------------------------- */
/* Find Function, Operation, Status, Script, Role */
/* ---------------------------------------------- */
select a.funcid, a.FUNCDESC, a.FUNCNAME, f.OPID, e.STATUSNAME, e.STATUSDESC, b.EXPRESSION, b.SCRIPT, c.ACCESS_STATUSID, c.ROLEID, d.SCREENID
from GERARD.RBAC_FUNCTIONMANIFEST a,
    GERARD.RBAC_FUNC_COMMUNITY_CONFIG b,
    GERARD.RBAC_FUNCTION_ROLE_REL c,
    GERARD.RBAC_SCRFUN_COMMUNITY_REL d,
    GERARD.RBAC_STATUSMANIFEST e,
    GERARD.OPERATION_CONFIG f
where a.funcid = b.funcid
--and e.STATUSID = c.ACCESS_STATUSID
and a.FUNCGROUPID = e.FUNCGROUPID
and f.FUNCNAME = a.FUNCNAME
and c.FUNCID = a.funcid
and d.FUNCID = a.FUNCID
and a.funcid = 'FU02101I'
--and d.SCREENID = 'SC308A'
--and e.statusname = a.FUNCNAME
--and e.STATUSNAME = 'New'
;

---------------------------------------------
select max(FIELDID) from GERARD.FIELD_CONFIG
where FIELDID like '%I';
select max(SYSFDID) from GERARD.FIELD_CONFIG_GROUP
where SYSFDID like '%I';

---------------------------------------------
SELECT MAX(RULEID) FROM GERARD.VALIDATION_RULES;

---------------------------------------------
select b.*, a.*
from gerard.validation_rules a,
    gerard.validation_ruleset b
where a.RULEID = b.RULEID
--and lower(a.definition) like lower('%>documentsRequired%')
--and lower(a.definition) like lower('%EXPR%')
--and a.fieldid in ('SFD0333L', 'SFD0894L','SFD0893L','SFD1033L')
-- and definition like '%descriptionOfGoods%'
and definition like '%documents%required%'
--and rulesetid = 'VRS017'
--and definition like '%SWIFT_CH%'
order by definition desc
;

---------------------------------------------
select a.*, b.*, c.*
from gerard.field_config_group a,
    gerard.field_sys_config b,
    gerard.field_config c
where a.SYSFDID = b.SYSFDID
and b.FIELDID = c.FIELDID
--and c.FUNCGROUPID = 'LCI'
and a.funcgroupid = 'STD'
--and b.SYSFDID in ('SFD0333L', 'SFD0894L','SFD0893L','SFD1033L')
and lower(a.properties) like lower('%error.narrative_not_found%')
;
