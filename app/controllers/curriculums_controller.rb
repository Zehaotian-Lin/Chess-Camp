class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  def index
    @curriculums = Curriculum.all
  end

  def show
    @past_camps_using = @curriculum.camps.past.chronological
    @upcoming_camps_using = @curriculum.camps.upcoming.chronological
  end

  def edit
    authorize! :edit, @curriculum
  end

  def new
    authorize! :new, @curriculum
    @curriculum = Curriculum.new
  end

  def create
    authorize! :new, @curriculum
    @curriculum = Curriculum.new(curriculum_params)
    if @curriculum.save
      redirect_to curriculum_path(@curriculum), notice: "#{@curriculum.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    authorize! :edit, @curriculum
    @curriculum.update(curriculum_params)
    if @curriculum.save
      redirect_to curriculum_path(@curriculum), notice: "#{@curriculum.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @curriculum
    @curriculum.destroy
    redirect_to curriculums_url, notice: "#{@curriculum.name} was removed from the system."
  end

  private
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    def curriculum_params
      params.require(:curriculum).permit(:name, :description, :min_rating, :max_rating, :active)
    end
end