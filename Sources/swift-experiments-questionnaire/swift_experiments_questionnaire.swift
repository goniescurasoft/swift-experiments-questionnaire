import SwiftUI

struct Question: Sendable {
  let id: Int
  let title: String
  let options: [Option]
  
  struct Option: Identifiable, Equatable {
    let id: Int
    let title: String
  }
}

struct Answer: Identifiable {
  let id: Int
  let optionId: Int
}

struct QuestionView: View {
  private let question: Question
  @State private var selected: Question.Option? = nil
  
  init(
    question: Question,
    selected: Question.Option? = nil
  ) {
    self.question = question
    self._selected = State(initialValue: selected)
  }
  
  var body: some View {
    VStack {
      Text(question.title)
        .font(.largeTitle)
      VStack(alignment: .leading) {
        ForEach(question.options) { option in
          Button {
            selected = option
          } label: {
            HStack {
              Image(systemName: option == selected ? "checkmark.circle" : "slash.circle")
              Text(option.title)
            }
            .foregroundStyle(option == selected ? .blue : .secondary)
          }
          .buttonStyle(.plain)
        }
      }
    }
  }
}

struct FinalView: View {
  private let questions: [Question]
  private let answers: [Answer]
  
  init(
    questions: [Question],
    answers: [Answer]
  ) {
    self.questions = questions
    self.answers = answers
  }
  
  func title(for answer: Answer) -> String {
    guard let question = self.questions.first(where:{ $0.id == answer.id })
    else { return "" }
    return question.title
  }
  
  func description(for answer: Answer) -> String {
    guard let question = self.questions.first(where:{ $0.id == answer.id }),
          let option = question.options.first(where:{ $0.id == answer.optionId })
    else { return "" }
    return option.title
  }
  
  var body: some View {
    VStack {
      ForEach(answers) { answer in
        Text(title(for: answer))
        Text("Answered: \(description(for: answer))")
      }
    }
  }
}

#Preview("Question") {
  let selectedAnswer = Question.Option(id: 2, title: "This is the second answer")
  QuestionView(
    question: Question(
      id: 1,
      title: "This is a question",
      options: [
        Question.Option(id: 1, title: "This the first answer"),
        selectedAnswer,
        Question.Option(id: 3, title: "This is the third ansert")
      ]
    ),
    selected: selectedAnswer
  )
}

#Preview("Final") {
  FinalView(
    questions: [
      Question(
        id: 1,
        title: "This is a question",
        options: [
          Question.Option(id: 1, title: "This the first answer"),
          Question.Option(id: 2, title: "This is the second answer"),
          Question.Option(id: 3, title: "This is the third ansert")
        ]
      )
    ],
    answers: [
      Answer(id: 1, optionId: 3)
    ]
  )
}
