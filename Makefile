WORKFLOWS = $(shell find . -name '*.ocrd.sh')

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    is-well-formed  Check that all OCRD-WF are well-formed"
	@echo ""
	@echo "  Variables"
	@echo ""

# END-EVAL

# Check that all OCRD-WF are well-formed
is-well-formed:
	for wf in $(WORKFLOWS);do echo -n "$$wf - "; ocrd wf is-well-formed $$wf;done
