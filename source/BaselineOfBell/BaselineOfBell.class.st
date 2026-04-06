Class {
	#name : 'BaselineOfBell',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBell',
	#package : 'BaselineOfBell'
}

{ #category : 'baselines' }
BaselineOfBell >> baseline: spec [

	<baseline>
	spec for: #pharo do: [ 
		self
			setUpDependencies: spec;
			setUpPackages: spec.

		spec
			group: 'Development' with: #( 'Tests' );
			group: 'CI' with: 'Tests';
			group: 'default' with: 'Development' ]
]

{ #category : 'baselines' }
BaselineOfBell >> setUpDependencies: spec [
			
	spec
		baseline: 'NeoJSON' with: [ spec repository: 'github://ba-st-dependencies/NeoJSON:v20' ];
		project: 'NeoJSON-Deployment' copyFrom: 'NeoJSON' with: [ spec loads: 'Deployment' ].
]

{ #category : 'baselines' }
BaselineOfBell >> setUpDeploymentPackages: spec [

	spec
		package: 'Bell-Logging' with: [ spec requires: 'NeoJSON-Deployment' ];
		group: 'Deployment' with: 'Bell-Logging'.

]

{ #category : 'baselines' }
BaselineOfBell >> setUpPackages: spec [

	self
		setUpDeploymentPackages: spec;
		setUpSUnitPackages: spec;
		setUpTestPackages: spec.

]

{ #category : 'initialization' }
BaselineOfBell >> setUpSUnitPackages: spec [

  spec
    package: 'Bell-SUnit' with: [ spec requires: #( 'Bell-Logging' ) ];
    group: 'Dependent-SUnit-Extensions' with: 'Bell-SUnit'.
  spec for: #( #'pharo10.x' #'pharo11.x' #'pharo12.x' ) do: [
      spec
        package: 'Bell-Pharo-10-Extensions';
        group: 'Dependent-SUnit-Extensions' with: 'Bell-SUnit'
    ]
]

{ #category : 'baselines' }
BaselineOfBell >> setUpTestPackages: spec [

	spec
		package: 'Bell-Logging-Tests'
		with: [ spec requires: #( 'Bell-Logging' 'Bell-SUnit' ) ];				
		group: 'Tests' with: 'Bell-Logging-Tests'.
]
