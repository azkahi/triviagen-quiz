class SurveysController < ApplicationController

  before_filter :load_survey, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category]
      surveys = []
      category = Category.select(:article).where(category: params[:category])
      category.each do |article|
        surveys << article.article
      end

      query = Survey::Survey.where({ name: surveys })
    else
      query = Survey::Survey
    end
    @surveys = query.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @survey = Survey::Survey.new(survey_type: view_context.get_survey_type(params[:type]))
  end

  def create
    puts Time.now.utc.strftime('%s%3N')
    @survey = Survey::Survey.new(params_whitelist)
    if @survey.valid? && @survey.save
      default_redirect
    else
      build_flash(@survey)
      render :new
    end
  end

  def process_openie

    all_openie = Openie.all
    all_openie.each do |openie|
      i = 0
      id_time = []
      while i < 5 do
        id_time[i] = Time.now.utc.strftime('%s%3N')
        sleep 0.001
        i = i + 1
      end
      i = 0
      j = 0
      choices = Openie.where(article: openie[:article]).where.not(relation: openie[:relation]).limit(3).order('RAND()')
      options_attributes = Hash.new
      true_answer = rand(3)

      while i < choices.count do
        if i == true_answer
          options_attributes[id_time[i]] = Hash['text' => openie[:entity2].encode("Windows-1252", invalid: :replace, undef: :replace), 'correct' => 1, '_destroy' => false]
        else
          options_attributes[id_time[i]] = Hash['text' => choices[j][:entity2].encode("Windows-1252", invalid: :replace, undef: :replace), 'correct' => 0, '_destroy' => false]
          j = j + 1
        end
        i = i + 1
      end

      question_string = openie[:entity1] + ' ' + openie[:relation] + '...'
      question_string = question_string.encode("Windows-1252", invalid: :replace, undef: :replace)
      attribute = Hash[id_time[4] => Hash['text' => question_string, '_destroy' => false, 'options_attributes' => options_attributes]]
      survey_test = Survey::Survey.new(:name => openie[:article].encode("Windows-1252", invalid: :replace, undef: :replace), :description => question_string, :survey_type => 0, :attempts_number => 0, :active => true, :questions_attributes => attribute)
      survey_test.valid?
      survey_test.save
    end
  end

  def edit
  end

  def show
  end

  def update
    if @survey.update_attributes(params_whitelist)
      default_redirect
    else
      build_flash(@survey)
      render :edit
    end
  end

  def destroy
    @survey.destroy
    default_redirect
  end

  private

  def default_redirect
    redirect_to surveys_path, notice: I18n.t("surveys_controller.#{action_name}")
  end

  def load_survey
    @survey = Survey::Survey.find(params[:id])
  end

  def params_whitelist
    params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes << :survey_type)
  end

end
