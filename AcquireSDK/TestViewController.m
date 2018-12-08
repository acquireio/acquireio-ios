//
//  TestViewController.m
//  AcquireSDK
//
//  Created by Raju Jangid on 11/30/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "TestViewController.h"
#import "TestFormViewController.h"
#import "TestPaymentFormViewController.h"


@interface TestViewController (){
    BOOL isScrollPage;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    id startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    _pageViewController.view.frame = CGRectMake(0, 70, _pageViewController.view.frame.size.width, _pageViewController.view.frame.size.height-90);
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}


- (id) viewControllerAtIndex:(NSUInteger)index
{
    // Create a new view controller and pass suitable data.
    if(index == 0){
        TestFormViewController * pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TestFormViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }else{
        TestPaymentFormViewController * pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TestPaymentFormViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index;
    if([viewController isKindOfClass:[TestFormViewController class]]){
        index = 0;
    }else{
        index = 1;
    }
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index;
    if([viewController isKindOfClass:[TestFormViewController class]]){
        index = 0;
    }else{
        index = 1;
    }
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    
    if (index > 1) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 1;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        if([[previousViewControllers objectAtIndex:0] isKindOfClass:[TestFormViewController class]]){
             [self selectSegment:1];
        }else{
            [self selectSegment:0];
        }
        
    }
}

-(void)selectSegment:(NSInteger)index{
    isScrollPage = YES;
    [self.segmentControl setSelectedSegmentIndex:index];
}


- (IBAction)changeSegment:(id)sender {
     [self changeViewIndex:(((UISegmentedControl *)sender).selectedSegmentIndex)];
}

-(void)changeViewIndex:(NSInteger)index{
    if(index == 0){
        TestFormViewController *startingViewController = [self viewControllerAtIndex:0];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }else{
        TestPaymentFormViewController *startingViewController = [self viewControllerAtIndex:1];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
}
@end
