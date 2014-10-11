//
//  ViewController.m
//  DeprocrastinatorV2
//
//  Created by Basel Farag on 9/27/14.
//  Copyright (c) 2014 NextTierGames. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property UITextField *text;
@property NSArray *textArray;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *thingsToDo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTextField.delegate = self;
    self.thingsToDo = [NSMutableArray new];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(id)sender {
    [self.thingsToDo addObject:self.myTextField.text];
    self.myTextField.text = @"";
    [self.myTextField resignFirstResponder];
    [self.myTableView reloadData];
}

#pragma UITableViewDataSource

//  Attaches the number of rows in TableView to the number of things stored in
//  the thingsToDo array.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.thingsToDo.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.thingsToDo objectAtIndex:indexPath.row];
    return cell;
}


@end
