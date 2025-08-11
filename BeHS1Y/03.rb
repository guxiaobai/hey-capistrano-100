
# uncomment_lines 'Capfile', /require.*assets/
# uncomment_lines 'Capfile', /require.*migrations/



uncomment_lines 'Capfile', /require.*bundle/
# Local config (<project_root>/.bundle/config
append :linked_dirs, '.bundle'

set :bundle_flags, '--verbose'
set :bundle_jobs, 8
set :bundle_env_variables, {} 

