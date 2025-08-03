class DistanceHandler
  class DistanceCalculationError < StandardError
    attr_reader :context

    def initialize(context = nil)
      @context = context
      super()
    end

    def message
      'Не удалось получить расстояние между двумя локациями'
    end
  end

  class DistanceDestinationsNotFoundError < StandardError
    attr_reader :context

    def initialize(context = nil)
      @context = context
      super()
    end

    def message
      'Не удалось найти места для рассчета расстояния'
    end
  end
end
