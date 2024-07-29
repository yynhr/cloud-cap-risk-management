using RiskService from './risk-service';

annotate RiskService.Risks with {
    title    @title: 'Title';
    prio     @title: 'Priority';
    descr    @title: 'Description';
    miti     @title: 'Mitigation';
    impact   @title: 'Impact';
    supplier @title: 'Supplier';
}

annotate RiskService.Mitigations with {
    ID          @(
        UI.Hidden,
        Common: {Text: description}
    );
    description @title: 'Description';
    owner       @title: 'Owner';
    timeline    @title: 'Timeline';
    risks       @title: 'Risks';
}

annotate RiskService.Risks with @(UI: {
    HeaderInfo      : {
        TypeName      : 'Risk',
        TypeNamePlural: 'Risks',
        Title         : {
            $Type: 'UI.DataField',
            Value: title
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: descr
        }
    },
    SelectionFields : [prio, supplier_ID],
    LineItem        : [
        {Value: title},
        {
            Value                : miti_ID,
            ![@HTML5.CssDefaults]: {width: '80%'}
        },
        {
            Value      : prio,
            Criticality: criticality
        },
        {
            Value      : impact,
            Criticality: criticality
        },
		{
			Value : supplier_ID
		}
    ],
    Facets          : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Main',
        Target: '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main: {Data: [
        {Value: miti_ID},
        {
            Value      : prio,
            Criticality: criticality
        },
        {
            Value      : impact,
            Criticality: criticality
        },
        {Value: supplier_ID},
        {Value: supplier.isBlocked},
    ]}
}, ) {

};

annotate RiskService.Risks with {
    miti @(Common: {
        //show text, not id for mitigation in the context of risks
        Text           : miti.description,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Mitigations',
            CollectionPath: 'Mitigations',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: miti_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        }
    });
}

annotate RiskService.Suppliers with {
    isBlocked @title: 'Supplier Blocked';
}

// Annotations for value help

annotate RiskService.Risks with {
    supplier @(Common.ValueList: {
        Label         : 'Suppliers',
        CollectionPath: 'Suppliers',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: supplier_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name'
            }
        ]
    });
}

annotate RiskService.Suppliers with {
    ID       @(
        title      : 'ID',
        Common.Text: Name
    );
    Name @title: 'Name';
}

annotate RiskService.Suppliers with @Capabilities.SearchRestrictions.Searchable: false;
