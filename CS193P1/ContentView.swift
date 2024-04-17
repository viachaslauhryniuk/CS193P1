import SwiftUI

struct ContentView: View {
    //Game Themes
    @State var futureTheme = ["👾","🤖","👽","⚙️","🔮","🧬","🕹️","💾","👾","🤖","👽","⚙️","🔮","🧬", "🕹️", "💾"]
    @State var animalTheme = ["🐶","🐱","🐹","🐼","🐸", "🦆","🐶","🐱","🐹","🐼","🐸", "🦆"]
    @State var foodTheme = ["🍋","🍏","🍉","🍇","🍋","🍏","🍉","🍇"]
    @State var chosenTheme: [String] = []
    let themes = ["Food Theme","Animal Theme","Future Theme"]
    let names = ["fork.knife","dog", "car.front.waves.down.fill"]
    //
    @State var chosenColor = Color.blue
    @State var gridDistance: CGFloat = 0.0
  
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            HStack{
                buttons
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive (minimum: gridDistance))]) {
            ForEach(0..<chosenTheme.count, id: \.self) { index in
                CardView(content: chosenTheme[index])
                    .aspectRatio (2/3,contentMode: .fit)
            }
        }
        .foregroundStyle(chosenColor)
    }
    
    var buttons: some View{
        HStack{
            ForEach(names, id: \.self){ name in
                let idx = names.firstIndex(of: name)
                VStack{
                    Image(systemName: name)
                        .imageScale(.large)
                        .padding(.bottom, 5)
                    Text(themes[idx ?? 0])
                        .font(.system(size: 12))
                }
                .padding(.horizontal,15)
                .foregroundStyle(chosenColor)
                .onTapGesture {
                    arrayPick(idx: idx ?? 0)
                }
            }
        }
    }
    
    func arrayPick(idx: Int) {
        switch idx{
        case 0:
            chosenTheme = foodTheme.shuffled()
            chosenColor = Color.green
            gridDistance = minimalDistance(for: foodTheme.count)
            
        case 1:
            chosenTheme = animalTheme.shuffled()
            chosenColor = Color.brown
            gridDistance = minimalDistance(for: animalTheme.count)
        case 2:
            chosenTheme = futureTheme.shuffled()
            chosenColor = Color.purple
            gridDistance = minimalDistance(for: futureTheme.count)
        default:
            print("index error")
        }
    }
    
    func minimalDistance(for count: Int) -> CGFloat {
        if count <= 9 {
            return 115.0
        }
        else {
            return 84.0
        }
    }
    
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle (cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text (content) .font (.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture { isFaceUp.toggle() }
    }
}
#Preview {
    ContentView()
}
