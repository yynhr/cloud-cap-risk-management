using {sap.ui.riskmanagement as my} from '../db/schema';
using {API_BUSINESS_PARTNER as bupa} from './external/API_BUSINESS_PARTNER';

@path: 'service/risk'
service RiskService {
    entity Risks       as projection on my.Risks;
    annotate Risks with @odata.draft.enabled;
    entity Mitigations as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
}

extend service RiskService with {
    @readonly entity Suppliers as
        projection on bupa.A_BusinessPartner {
            key BusinessPartner as ID,
                BusinessPartnerFullName as Name,
                BusinessPartnerIsBlocked as isBlocked
        }
}
