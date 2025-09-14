import SwiftUI

struct Question {
  let title: String
  let options: [Answer]
}

struct Answer: Identifiable, Equatable {
  let id: Int
  let title: String
}

struct QuestionView: View {
  private let question: Question
  @State private var selected: Answer? = nil
  
  init(
    question: Question,
    selected: Answer? = nil
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

#Preview {
  let selectedAnswer = Answer(id: 2, title: "This is the second answer")
  QuestionView(
    question: Question(
      title: "This is a question",
      options: [
        Answer(id: 1, title: "This the first answer"),
        selectedAnswer,
        Answer(id: 3, title: "This is the third ansert")
      ]
    ),
    selected: selectedAnswer
  )
}
