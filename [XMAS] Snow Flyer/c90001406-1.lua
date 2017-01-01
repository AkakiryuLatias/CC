-- Flash Flyer - Kaori
function c90001406.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--ATK boost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001406.tg)
	e2:SetRange(LOCATION_PZONE)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--DEF boost
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e3)
	---cannot be targeted
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c90001406.target)
	e4:SetValue(aux.tgval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetValue(1)
	e5:SetValue(c90001406.indval)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_BATTLE_DESTROYED)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1,90001406)
	e6:SetCondition(c90001406.con)
	e6:SetTarget(c90001406.sptg)
	e6:SetOperation(c90001406.spop)
	c:RegisterEffect(e6)
end

--Flyer defense and power up
function c90001406.tg(e,c)
	return (c:IsSetCard(0xc9) or c:IsSetCard(0x4c9) or c:IsSetCard(0x5c9)) and c:IsType(TYPE_MONSTER)
end

--Flyer targeting protection
function c90001406.target(e,c)
	return (c:IsSetCard(0xc9) or c:IsSetCard(0x4c9) or c:IsSetCard(0x5c9)) and c:IsType(TYPE_MONSTER)
end

function c90001406.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--ss
function c90001406.con(e,tp,eg,ep,ev,re,r,rp)
	local lv=0
	local tc=eg:GetFirst()
	while tc do
		if tc:IsReason(REASON_DESTROY) and tc:IsSetCard(0xc9) or tc:IsSetCard(0x4c9) or tc:IsSetCard(0x5c9)and not tc:IsPreviousLocation(LOCATION_SZONE) then
end

function c90001406.spfilter(c,e,tp)
	return (c:IsSetCard(0xc9) or c:IsSetCard(0x4c9) or c:IsSetCard(0x5c9)) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90001406.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001406.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c90001406.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001406.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
