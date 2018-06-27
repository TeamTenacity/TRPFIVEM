resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
	'vehicles.meta',
	'carvariations.meta',
	'handling.meta',
	'vehiclelayouts_armordillo',
	'vehiclelayouts_factionpack',
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts_armordillo'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts_factionpack'

client_script 'vehicle_names.lua'