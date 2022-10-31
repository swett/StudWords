//
//  FlashCardViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 26.10.2022.
//

//struct FlashCardModel {
//    let id: String
//    let text: String
//    let answers: [String]
//    let answer: String
//}



class FlashCardViewModel {
    weak var view: FlashCardVC?
    var questions: [Question] = []
    var currentQuestion: Question?
    private let storage: QuizProtocol!
    var correctAnswers: Int = 0
    
    
    init(storage: QuizProtocol) {
        self.storage = storage
        setup()
        print(" This in a flashCardViewModel \(questions)")
    }
    
    func setup() {
        storage.getQuestons { [weak self] questions, error in
            guard let questions = questions else {
                assertionFailure("Loshara")
                return
            }
            self?.questions = questions
            print(questions)
        }
    }
}


extension FlashCardViewModel {
    
    func viewDidLoad() {
        guard let first = questions.first else {
            assertionFailure("Missing first question")
            return
        }
      didFind(question: first)
    }
    
    func checkAnswer(with index: Int) -> Bool {
        guard let currentQuestion = currentQuestion else {
            assertionFailure("Missing current question")
            return false
        }
        return currentQuestion.answers[index].correct
    }
    
    private func getQuestion(after question: Question?) -> Question? {
        guard let question = question,
              let index = questions.firstIndex(where: { $0.id == question.id }) else {
                  return nil
              }
        
        let next = index + 1
        guard next < questions.count else {
            return nil
        }
        
        return questions[next]
    }
    
    func didTapAnswer(with index: Int) {
        let correct = checkAnswer(with: index)
        if correct {
            guard let nextQuestion = getQuestion(after: currentQuestion) else {
                view?.showResult()
                return
            }
            didFind(question: nextQuestion)
        } else {
            view?.showMistake(at: index)
        }
       
    }
    
   private func didFind(question: Question) {
        currentQuestion = question
        view?.showCard(with: question)
    }
    
}
