require 'mkmf'

abort 'missing crystal' unless find_executable('crystal')
abort 'missing llvm tooling' unless find_executable('llvm-config')

# Dirty patching
def create_makefile(_, _ = nil)
end

create_makefile(nil)
