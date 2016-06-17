class QsetsController < ApplicationController
	def index
		@qsets = Qset.all
	end
	def create

	end

	private

	def qset_params
		params.require(:qset).permit(:)
end
