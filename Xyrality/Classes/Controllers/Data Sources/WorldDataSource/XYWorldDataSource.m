//
//  XYDataSource.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYWorldDataSource.h"
#import "XYDataManager.h"
#import "XYCellWithObjectDelegate.h"

@interface XYWorldDataSource ()

// XYB
@property (nonatomic, weak  ) IBOutlet UITableView *tableView;

// Internal
@property (nonatomic, strong)          NSString    *reuseCellIdentifierForAllItems;
@property (nonatomic, weak  )          NSArray     *items;


@end

@implementation XYWorldDataSource

- (void)awakeFromNib {
    
    self.items = [XYDataManager sharedInstance].worlds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell <XYCellWithObjectDelegate> *cell =
        [tableView dequeueReusableCellWithIdentifier:self.reuseCellIdentifierForAllItems];
	
	cell.object = self.items[indexPath.row];
	
	return cell;
}

@end
