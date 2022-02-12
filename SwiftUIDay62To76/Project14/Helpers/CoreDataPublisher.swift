//
//  CoreDataPublisher.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import Combine
import CoreData
import Foundation

/// Custom core data helpers that can be implemented in Observable Class
/**
 ```
    // Declaration in VM class
    private let container = ChallengeDataController.shared.container
 
    // Usage
     CDPublisher(request: CachedUser.fetchRequest(), context: container.viewContext)
     .map ({ Result
        // do something
     })
     .receive (on: DispatchQueue.main)
     .sink(receiveCompletion: { in }, receiveValue: { [weak self] ReturnedResult in
        print ("Loaded data successfullyu)
     })
     .store(in: &cancelables)
 ```
 */
class CDPublisher<Entity>: NSObject, NSFetchedResultsControllerDelegate, Publisher where Entity: NSManagedObject {
    typealias Output = [Entity]
    typealias Failure = Error
    
    private let request: NSFetchRequest<Entity>
    private let context: NSManagedObjectContext
    private let subject: CurrentValueSubject<[Entity], Failure>
    private var resultController: NSFetchedResultsController<NSManagedObject>?
    private var subscriptions = 0
    
    init(request: NSFetchRequest<Entity>, context: NSManagedObjectContext) {
        if request.sortDescriptors == nil { request.sortDescriptors = [] }
        self.request = request
        self.context = context
        subject = CurrentValueSubject([])
        super.init()
    }
    
    func receive<S>(subscriber: S)
    where S: Subscriber, CDPublisher.Failure == S.Failure, CDPublisher.Output == S.Input {
        var start = false
        
        DispatchQueue(label: "com.challenge.mySerialQueue").sync {
            subscriptions += 1
            start = subscriptions == 1
        }
        
        if start {
            let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context,
                                                        sectionNameKeyPath: nil, cacheName: nil)
            controller.delegate = self
            
            do {
                try controller.performFetch()
                let result = controller.fetchedObjects ?? []
                subject.send(result)
            } catch {
                subject.send(completion: .failure(error))
            }
            resultController = controller as? NSFetchedResultsController<NSManagedObject>
        }
        CDSubscription(fetchPublisher: self, subscriber: AnySubscriber(subscriber))
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let result = controller.fetchedObjects as? [Entity] ?? []
        subject.send(result)
    }
    
    private func dropSubscription() {
        objc_sync_enter(self)
        subscriptions -= 1
        let stop = subscriptions == 0
        objc_sync_exit(self)
        
        if stop {
            resultController?.delegate = nil
            resultController = nil
        }
    }
    
    private class CDSubscription: Subscription {
        private var fetchPublisher: CDPublisher?
        private var cancellable: AnyCancellable?
        
        @discardableResult
        init(fetchPublisher: CDPublisher, subscriber: AnySubscriber<Output, Failure>) {
            self.fetchPublisher = fetchPublisher
            
            subscriber.receive(subscription: self)
            
            cancellable = fetchPublisher.subject.sink(receiveCompletion: { completion in
                subscriber.receive(completion: completion)
            }, receiveValue: { value in
                _ = subscriber.receive(value)
            })
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            cancellable?.cancel()
            cancellable = nil
            fetchPublisher?.dropSubscription()
            fetchPublisher = nil
        }
    }
    
}
