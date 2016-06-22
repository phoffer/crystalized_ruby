require 'mkmf'

abort 'missing crystal' unless find_executable('crystal')

# Dirty patching
def create_makefile(_, _ = nil)
end

create_makefile(nil)
