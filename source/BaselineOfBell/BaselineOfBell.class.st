Class {
	#name : #BaselineOfBell,
	#superclass : #BaselineOf,
	#category : #BaselineOfBell
}

{ #category : #baselines }
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

{ #category : #baselines }
BaselineOfBell >> setUpDependencies: spec [
			
	spec
		baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
		project: 'NeoJSON-Core' copyFrom: 'NeoJSON' with: [ spec loads: 'core' ].
]

{ #category : #baselines }
BaselineOfBell >> setUpDeploymentPackages: spec [

	spec
		package: 'Bell-Logging' with: [ spec requires: 'NeoJSON-Core' ];
		group: 'Deployment' with: 'Bell-Logging'.

]

{ #category : #baselines }
BaselineOfBell >> setUpPackages: spec [

	self
		setUpDeploymentPackages: spec;
		setUpSUnitPackages: spec;
		setUpTestPackages: spec.

]

{ #category : #initialization }
BaselineOfBell >> setUpSUnitPackages: spec [

	spec
		package: 'Bell-SUnit' with: [ spec requires: #( 'Bell-Logging' ) ];
		group: 'Dependent-SUnit-Extensions' with: 'Bell-SUnit'
]

{ #category : #baselines }
BaselineOfBell >> setUpTestPackages: spec [

	spec
		package: 'Bell-Logging-Tests'
		with: [ spec requires: #( 'Bell-Logging' 'Bell-SUnit' ) ];				
		group: 'Tests' with: 'Bell-Logging-Tests'.
]
